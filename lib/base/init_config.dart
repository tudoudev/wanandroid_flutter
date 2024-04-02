// 全局设置
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/res/strings.dart';

//日志
final logger = Logger();

initConfig() {
  //下拉刷新配置
  EasyRefresh.defaultHeaderBuilder = () => const MaterialHeader(color: MColors.appMain);
  EasyRefresh.defaultFooterBuilder = () => const ClassicFooter(
        dragText: MStrings.commonDragText,
        readyText: MStrings.commonReadyText,
        processingText: MStrings.commonReadyText,
        processedText: MStrings.commonProcessedText,
        noMoreText: MStrings.commonNoMoreText,
        showMessage: false,
        failedText: MStrings.commonFailedText,
      );
  //加载配置
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorType= EasyLoadingIndicatorType.circle
    ..toastPosition = EasyLoadingToastPosition.bottom;
}
