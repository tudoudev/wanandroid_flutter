/*
 * Description：<首页>
 * Created by：zzl
 * Time：2024/3/8  09:10
 */
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_state_keep_alive.dart';
import 'package:wanandroid_flutter/page/common/view/article_page.dart';
import 'package:wanandroid_flutter/page/project/view/project_article_page.dart';
import 'package:wanandroid_flutter/page/project/viewmodel/project_view_model.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends BaseStateKeepAlive<ProjectViewModel, ProjectPage> {
  @override
  void initState() {
    super.initState();
    //初始化请求
    mViewModel.initHttp();
  }

  @override
  Widget initView(BuildContext context) {
    return PageStateProvider(
      viewModel: mViewModel,
      onLoadRetry: () => mViewModel.initHttp(),
      builder: (context) => ContentWidget(
        chaptersEntityList: mViewModel.chaptersEntityList.value!,
      ),
    );
  }
}

class ContentWidget extends StatefulHookWidget {
  final List<ChaptersEntity> chaptersEntityList;

  const ContentWidget({super.key, required this.chaptersEntityList});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    _tabController = useTabController(initialLength: widget.chaptersEntityList.length);
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: widget.chaptersEntityList.map((item) => Tab(text: item.name)).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.chaptersEntityList.map((item) => ArticlePage(id: item.id)).toList(),
          ),
        )
      ],
    );
  }
}
