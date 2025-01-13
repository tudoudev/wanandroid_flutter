import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/injector/injector.dart';

abstract class BaseStateKeepAlive<VM extends BaseViewModel, W extends StatefulWidget> extends State<W> with AutomaticKeepAliveClientMixin {
  late VM mViewModel;

  @override
  void initState() {
    super.initState();
    mViewModel = getIt.get<VM>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) => mViewModel,
      child: initView(context),
    );
  }

  Widget initView(BuildContext context);

  @override
  bool get wantKeepAlive => true;
}
