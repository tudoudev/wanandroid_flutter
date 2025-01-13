/*
 * Description：<体系>
 * Created by：zzl
 * Time：2024/3/8  09:10
 */
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wanandroid_flutter/base/base_state_keep_alive.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/main_view_model.dart';
import 'package:wanandroid_flutter/page/system/view/knowledge_tree_page.dart';
import 'package:wanandroid_flutter/page/system/view/navigation_page.dart';
import 'package:wanandroid_flutter/res/m_string.dart';

class SystemPage extends StatefulHookWidget {
  const SystemPage({super.key});

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends BaseStateKeepAlive<MainViewModel, SystemPage> {
  final _list = [MString.commonText_4, MString.commonText_6];
  late TabController _tabController;

  @override
  Widget initView(BuildContext context) {
    _tabController = useTabController(initialLength: _list.length);
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.fill,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: false,
            tabs: _list.map((item) => Tab(text: item)).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [KnowledgeTreePage(), NavigationPage()],
          ),
        ),
      ],
    );
  }
}
