import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_entity.dart';
import 'package:wanandroid_flutter/constant/common_constant.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';

import '../res/m_string.dart';

class BaseViewModel extends ChangeNotifier {

  //页面请求状态
  var pageState = PageState.loading;

  //请求页码(refresh)
  var requestNum = CommonConstant.initialPageNum;

  //当前页码(refresh)
  var currentNum = CommonConstant.initialPageNum;

  //下拉刷新控制器
  late final EasyRefreshController controller = EasyRefreshController(controlFinishRefresh: true, controlFinishLoad: true);

  /*
   * 处理数据
   * oldList 老数据
   * newList 新数据
   */
  void handleData<T>(SelectorData<List<T>> oldList, List<T>? newList) {
    if (requestNum == CommonConstant.initialPageNum) {
      //清空数据
      oldList.value?.clear();
      //结束刷新
      controller.finishRefresh();
    } else {
      if (newList!.isEmpty) {
        //回退请求页码
        if (requestNum > CommonConstant.initialPageNum) {
          requestNum--;
        }
        //结束加载
        controller.finishLoad(IndicatorResult.noMore);
      } else {
        //结束加载
        controller.finishLoad(IndicatorResult.success);
      }
    }
    oldList.value?.addAll(newList!);
    oldList.call();
  }

  /*
   * 请求
   */
  Future request(Function() request, {RequestType requestType = RequestType.jingMo}) async {
    //请求前操作
    prepare(requestType);
    try {
      await request();
      //请求后操作
      completed(requestType);
    } catch (e) {
      exception(e, requestType);
    }
  }

  /*
   * 请求前操作
   */
  prepare(RequestType requestType) {
    //加载界面
    if (requestType == RequestType.page) {
      pageState = PageState.loading;
      notifyListeners();
    }
    //加载框
    if (requestType == RequestType.dialog) {
      EasyLoading.show(status: MString.tdLoadingWithPoint);
    }
  }

  /*
   * 请求后操作
   */
  completed(RequestType requestType) {
    //加载界面
    if (requestType == RequestType.page) {
      pageState = PageState.success;
    }
    //刷新操作
    if (requestType == RequestType.refresh) {
      //设置当前页码
      currentNum = requestNum;
    }
    //加载框
    if (requestType == RequestType.dialog) {
      EasyLoading.dismiss();
    }
    //更新界面
    notifyListeners();
  }

  /*
   * 响应处理
   * ok 成功回调
   */
  Future handle<T>(Future<BaseEntity<T>> Function() response, Function(T) ok, {RequestType requestType = RequestType.jingMo}) async {
    return await response().then((response) {
      //请求成功
      if (response.errorCode == 0) {
        //成功回调
        ok(response.data as T);
      }
      //请求成功(code异常)
      else {
        throw ErrorException(response.errorCode, response.errorMsg);
      }
    });
  }

  /*
   * 异常
   */
  void exception(dynamic e, RequestType requestType) async {
    String? message = "";
    //请求成功(code异常)
    if (e is ErrorException) {
      message = e.errorMsg;
      //登录过期
      if (e.errorCode == -1001) {
        GoRouter.of(CommonConstant.navKey.currentState!.context).push(RouterConstant.LoginPage);
      }
    }
    //Http错误
    else {
      message = MString.commonOnFailure;
    }
    //加载界面
    if (requestType == RequestType.page) {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        pageState = PageState.noNetwork;
      } else {
        pageState = PageState.failed;
      }
      notifyListeners();
    }
    //刷新操作
    if (requestType == RequestType.refresh) {
      controller.finishRefresh();
      controller.finishLoad(IndicatorResult.fail);
      EasyLoading.showToast(message);
      //恢复请求页码
      requestNum = currentNum;
    }
    //加载框
    if (requestType == RequestType.dialog) {
      EasyLoading.dismiss();
      EasyLoading.showToast(message);
    }
  }
}

/*
 * 请求类型
 */
enum RequestType {
  //页面请求
  page,
  //刷新控件请求
  refresh,
  //弹框请求
  dialog,
  //静默请求
  jingMo,
}

/*
 * 页面请求状态
 */
enum PageState {
  //加载中
  loading,
  //错误
  failed,
  //无网络
  noNetwork,
  //成功
  success,
}

class ErrorException {
  final int? errorCode;
  final String errorMsg;

  ErrorException(this.errorCode, this.errorMsg);
}
