/*
 * Description：<首页>
 * Created by：zzl
 * Time：2024/3/8  09:10
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/base/page_state_provider.dart';
import 'package:wanandroid_flutter/base/selector_widget.dart';
import 'package:wanandroid_flutter/page/main/view/drawer_page.dart';
import 'package:wanandroid_flutter/page/project/view/project_article_page.dart';
import 'package:wanandroid_flutter/page/project/viewmodel/project_view_model.dart';
import 'package:wanandroid_flutter/res/strings.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends BaseState<ProjectViewModel, ProjectPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    //初始化请求
    mViewModel.initView();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text(MStrings.commonText_5),
      ),
      body: PageStateProvider(
        viewModel: mViewModel,
        onLoadRetry: () => mViewModel.initView(),
        onInit: () => _tabController = TabController(length: mViewModel.chaptersEntityList.value!.length, vsync: this),
        builder: (context) => Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                controller: _tabController,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                tabs: mViewModel.chaptersEntityList.value!.map((item) => Tab(text: item.name)).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: mViewModel.chaptersEntityList.value!.map((item) => ProjectArticlePage(id: item.id)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
