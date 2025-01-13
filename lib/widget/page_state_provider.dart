import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/base/resource_config.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';
import 'package:wanandroid_flutter/util/common_util.dart';

import '../res/m_string.dart';

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
            //加载中
            case PageState.loading:
              return const SpinKitCircle(color: MColors.appMain, size: 50);
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
                          getImgPath("ui_loading_failed"),
                          width: 250,
                        ),
                        const Text(MString.commonLoadingFailed)
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
                          getImgPath("ui_oading_no_network"),
                          width: 250,
                        ),
                        const Text(MString.commonLoadingNoNetWork, textAlign: TextAlign.center)
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
