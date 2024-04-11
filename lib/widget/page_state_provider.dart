import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/util/common_util.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

class PageStateProvider<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;
  final Widget Function(BuildContext context) builder;
  final void Function() onLoadRetry;
  final void Function()? onInit;

  const PageStateProvider({super.key, required this.viewModel, required this.builder, required this.onLoadRetry, this.onInit});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: SelectorWidget<T, PageState>(
        selector: (context, _) => viewModel.pageState,
        builder: (context, it, child) {
          switch (it) {
            //加载成功
            case PageState.loading:
              return SpinKitCircle(color: MColors.appMain, size: 50.w);
            //加载失败
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
                        Text(StringUtil.get().commonLoadingFailed)
                      ],
                    ),
                  ),
                ),
              );
            //加载失败-无网络
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
                        Text(StringUtil.get().commonLoadingNoNetWork, textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ),
              );
            //加载成功
            case PageState.success:
              if (onInit != null) {
                onInit!();
              }
              return builder(context);
          }
        },
      ),
    );
  }
}
