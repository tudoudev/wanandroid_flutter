import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/page_state_provider.dart';
import 'package:wanandroid_flutter/page/home/view/article_page.dart';
import 'package:wanandroid_flutter/page/main/view/drawer_page.dart';
import 'package:wanandroid_flutter/page/wxchat/viewmodel/wxchat_view_model.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

/*
 * Description：<公众号>
 * Created by：zzl
 * Time：2024/3/8  09:10
 */
class WxChatPage extends StatefulWidget {
  const WxChatPage({super.key});

  @override
  State<WxChatPage> createState() => _WxChatPageState();
}

class _WxChatPageState extends BaseState<WxChatViewModel, WxChatPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
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
        title: Text(StringUtil.get().commonText_3),
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
                children: mViewModel.chaptersEntityList.value!.map((item) => ArticlePage(id: item.id)).toList(),
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
