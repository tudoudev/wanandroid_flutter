import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/listview_widget.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/my_points_view_model.dart';
import 'package:wanandroid_flutter/widget/refresh_widget.dart';

import '../../../res/m_string.dart';

/*
 * Description：<我的积分>
 * Created by：zzl
 * Time：2025/1/13  16:23
 */
class MyPointsPage extends StatefulWidget {
  const MyPointsPage({super.key});

  @override
  State<MyPointsPage> createState() {
    return _MyPointsPageState();
  }
}

class _MyPointsPageState extends BaseState<MyPointsViewModel, MyPointsPage> {
  @override
  void initState() {
    super.initState();
    //初始化view
    mViewModel.initHttp(mViewModel.requestNum, requestType: RequestType.page);
  }

  @override
  Widget initView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MString.commonText_12),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: PageStateProvider(
        viewModel: mViewModel,
        onLoadRetry: () => mViewModel.initHttp(mViewModel.requestNum, requestType: RequestType.page),
        builder: (context) {
          var integrateEntityList = mViewModel.integrateEntityList.value!;
          return
            RefreshWidget(
              viewModel: mViewModel,
              onRefresh: () async => await mViewModel.initHttp(mViewModel.requestNum, requestType: RequestType.refresh),
              onLoad: () async => await mViewModel.initHttp(mViewModel.requestNum, requestType: RequestType.refresh),
              child: ListViewWidget(
                separatorBuilder: (context, index) => const Divider(thickness: 0.6, height: 0),
                itemCount: integrateEntityList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    integrateEntityList[index].reason,
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    integrateEntityList[index].desc,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(
                    "+${integrateEntityList[index].coinCount}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
