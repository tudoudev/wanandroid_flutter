import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/my_points_view_model.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

class MyPointsPage extends StatefulWidget {
  const MyPointsPage({super.key});

  @override
  State<MyPointsPage> createState() {
    return _MyPointsPageState();
  }
}

class _MyPointsPageState extends BaseState<MyPointsViewModel,MyPointsPage> {
  @override
  void initState() {
    super.initState();
    //初始化view
    mViewModel.initView(RequestType.page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtil.get().main_4),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: PageStateProvider(
        viewModel: mViewModel,
        onLoadRetry: () => mViewModel.initView(RequestType.page),
        builder: (context) => const Text(""),
      ),
    );
  }
}
