import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/constant/common_constant.dart';

class RefreshWidget extends StatelessWidget {
  final BaseViewModel viewModel;
  final Function()? onRefresh;
  final Function()? onLoad;
  final Widget child;

  const RefreshWidget({super.key, required this.viewModel, this.onRefresh, this.onLoad, required this.child});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: viewModel.controller,
      onRefresh: onRefresh == null
          ? null
          : () async {
              viewModel.requestNum = CommonConstant.initialPageNum;
              await onRefresh!();
            },
      onLoad: onLoad == null
          ? null
          : () async {
              viewModel.requestNum++;
              await onLoad!();
            },
      child: child,
    );
  }
}
