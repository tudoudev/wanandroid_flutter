// 全局设置
import 'package:easy_refresh/easy_refresh.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';
import 'package:wanandroid_flutter/util/sp_util.dart';

import '../res/m_string.dart';

//日志
final logger = Logger();
//事件总线
final eventBus = EventBus();

initConfig() async {
  //下拉刷新配置
  EasyRefresh.defaultHeaderBuilder = () => const MaterialHeader(color: MColors.appMain);
  EasyRefresh.defaultFooterBuilder = () => const ClassicFooter(
        dragText: MString.commonDragText,
        readyText: MString.tdLoadingWithPoint,
        processingText: MString.tdLoadingWithPoint,
        processedText: MString.commonProcessedText,
        noMoreText: MString.commonNoMoreText,
        showMessage: false,
        failedText: MString.commonFailedText,
      );
  //加载配置
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..toastPosition = EasyLoadingToastPosition.bottom;
  //初始化SharedPreferences
  await SpUtil.getInstance();
}
