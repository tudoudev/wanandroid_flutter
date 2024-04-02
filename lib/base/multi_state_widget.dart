import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/res/strings.dart';
import 'package:wanandroid_flutter/util/common_util.dart';

class PageStateWidget extends StatelessWidget {
  final Widget Function(BuildContext context) builder;
  final PageState pageState;
  final void Function() onLoadRetry;

  const PageStateWidget({super.key, required this.builder, required this.pageState, required this.onLoadRetry});

  @override
  Widget build(BuildContext context) {
    switch (pageState) {
      case PageState.loading:
        return SpinKitCircle(color: MColors.appMain, size: 50.w);
      case PageState.failed:
        return GestureDetector(
          onTap: onLoadRetry,
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            height: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    CommonUtil.getImgPath("ui_loading_failed"),
                    width: 250.w,
                  ),
                  const Text(MStrings.commonLoadingFailed)
                ],
              ),
            ),
          ),
        );
      case PageState.noNetwork:
        return GestureDetector(
          onTap: onLoadRetry,
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            height: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    CommonUtil.getImgPath("ui_oading_no_network"),
                    width: 250.w,
                  ),
                  const Text(MStrings.commonLoadingNoNetWork, textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
        );
      case PageState.success:
        return builder(context);
    }
  }
}
