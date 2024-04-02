import 'package:flutter/cupertino.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/injector/injector.dart';

abstract class BaseState<VM extends BaseViewModel, W extends StatefulWidget> extends State<W> {
  late VM mViewModel;

  @override
  void initState() {
    super.initState();
    mViewModel = getIt.get<VM>();
  }
}
