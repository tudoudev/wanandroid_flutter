/*
 * Description：<体系>
 * Created by：zzl
 * Time：2024/3/8  09:10
 */
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/page/main/view/drawer_page.dart';
import 'package:wanandroid_flutter/page/system/view/knowledge_tree_page.dart';
import 'package:wanandroid_flutter/page/system/view/navigation_page.dart';
import 'package:wanandroid_flutter/res/strings.dart';

class SystemPage extends StatefulWidget {
  const SystemPage({super.key});

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final _list = [MStrings.commonText_4, MStrings.commonText_6];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _list.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text(MStrings.commonText_4),
      ),
      body: Column(
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
