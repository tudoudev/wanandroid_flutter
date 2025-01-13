import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/page/common/widget/article_widget.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/my_collect_view_model.dart';
import 'package:wanandroid_flutter/widget/listview_widget.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/my_points_view_model.dart';
import 'package:wanandroid_flutter/widget/refresh_widget.dart';

import '../../../res/m_string.dart';

/*
 * Description：<我的收藏>
 * Created by：zzl
 * Time：2025/1/13  16:23
 */
class MyCollectPage extends StatefulWidget {
  const MyCollectPage({super.key});

  @override
  State<MyCollectPage> createState() {
    return _MyCollectPageState();
  }
}

class _MyCollectPageState extends BaseState<MyCollectViewModel, MyCollectPage> {
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
        title: const Text(MString.commonText_13),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: PageStateProvider(
        viewModel: mViewModel,
        onLoadRetry: () => mViewModel.initHttp(mViewModel.requestNum, requestType: RequestType.page),
        builder: (context) {
          var articleEntityList = mViewModel.articleEntityList.value!;
          return RefreshWidget(
            viewModel: mViewModel,
            onRefresh: () async => await mViewModel.initHttp(mViewModel.requestNum, requestType: RequestType.refresh),
            onLoad: () async => await mViewModel.initHttp(mViewModel.requestNum, requestType: RequestType.refresh),
            child: ListViewWidget(
              separatorBuilder: (context, index) => const Divider(thickness: 0.6, height: 0),
              itemCount: articleEntityList.length,
              itemBuilder: (context, index) => ArticleWidget(
                articleEntity: articleEntityList[index],
                isShowCollect: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
