import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/base/multi_state_widget.dart';
import 'package:wanandroid_flutter/base/refresh_widget.dart';
import 'package:wanandroid_flutter/base/selector_widget.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/router_helper.dart';
import 'package:wanandroid_flutter/page/system/model/navigation_entity.dart';
import 'package:wanandroid_flutter/page/system/viewmodel/system_view_model.dart';
import 'package:wanandroid_flutter/res/colors.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends BaseState<SystemViewModel, NavigationPage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  // 是否显示悬浮按钮
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    //初始化view
    mViewModel.naviJson(RequestType.page);
    //listview滚动监听
    _scrollController.addListener(() {
      if (_scrollController.offset < 200 && _isShowFAB) {
        setState(() {
          _isShowFAB = false;
        });
      } else if (_scrollController.offset >= 200 && !_isShowFAB) {
        setState(() {
          _isShowFAB = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (_) => mViewModel,
          child: SelectorWidget<SystemViewModel, PageState>(
              selector: (context, _) => mViewModel.pageState,
              builder: (context, it, child) {
                return PageStateWidget(
                  pageState: mViewModel.pageState,
                  onLoadRetry: () => mViewModel.naviJson(RequestType.page),
                  builder: (context) => Column(
                    children: [
                      SelectorWidget<SystemViewModel, SelectorData<List<NavigationEntity>>>(
                        selector: (context, _) => mViewModel.navigationEntityList,
                        builder: (context, it, child) {
                          return Expanded(
                            child: RefreshWidget(
                              viewModel: mViewModel,
                              onRefresh: () async => await mViewModel.naviJson(RequestType.refresh),
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Divider(thickness: 0.3.w, height: 0);
                                },
                                controller: _scrollController,
                                itemCount: it.value!.length,
                                itemBuilder: (context, index) {
                                  var item = it.value![index];
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(bottom: 8.w),
                                          child: Text(
                                            item.name,
                                            style: TextStyle(fontSize: 15.sp),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Wrap(
                                            spacing: 2.w,
                                            children: item.articles
                                                .map((e) => InkWell(
                                                      onTap: () {
                                                        context.goto(RouterConstant.webView, extra: {'url': e.link, 'title': e.title});
                                                      },
                                                      child: Chip(
                                                        label: Text(
                                                          e.title,
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Color.fromARGB(255, Random().nextInt(190), Random().nextInt(190), Random().nextInt(190)),
                                                              fontStyle: FontStyle.italic),
                                                        ),
                                                        labelPadding: EdgeInsets.only(left: 2.w, right: 2.w),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              })),
      floatingActionButton: !_isShowFAB
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                // 回到顶部时要执行的动画
                _scrollController.animateTo(0, duration: const Duration(milliseconds: 2000), curve: Curves.ease);
              },
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
