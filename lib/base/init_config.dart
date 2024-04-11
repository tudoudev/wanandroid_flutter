// 全局设置
import 'package:easy_refresh/easy_refresh.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/util/sp_util.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

//日志
final logger = Logger();
//事件总线
final eventBus = EventBus();

initConfig() async {
  //下拉刷新配置
  EasyRefresh.defaultHeaderBuilder = () => const MaterialHeader(color: MColors.appMain);
  EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
        dragText: StringUtil.get().commonDragText,
        readyText: StringUtil.get().commonReadyText,
        processingText: StringUtil.get().commonReadyText,
        processedText: StringUtil.get().commonProcessedText,
        noMoreText: StringUtil.get().commonNoMoreText,
        showMessage: false,
        failedText: StringUtil.get().commonFailedText,
      );
  //加载配置
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..toastPosition = EasyLoadingToastPosition.bottom;
  //初始化SharedPreferences
  await SpUtil.getInstance();
}
