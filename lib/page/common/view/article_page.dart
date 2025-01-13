import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wanandroid_flutter/base/app_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_state_keep_alive.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/page/common/widget/article_widget.dart';
import 'package:wanandroid_flutter/res/m_string.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/widget/refresh_widget.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/viewmodel/wxchat_view_model.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';

class ArticlePage extends StatefulHookWidget {
  final int id;

  const ArticlePage({super.key, required this.id});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends BaseStateKeepAlive<WxChatViewModel, ArticlePage> {
  late ScrollController _scrollController ;

  // 是否显示悬浮按钮
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    //初始化view
    mViewModel.wxArticleList(RequestType.page, widget.id);
  }

  @override
  Widget initView(BuildContext context) {
    _scrollController = useScrollController();
    //listview滚动监听
    useEffect(() {
      temp() {
        if (_scrollController.offset < 200 && _isShowFAB) {
          setState(() {
            _isShowFAB = false;
          });
        } else if (_scrollController.offset >= 200 && !_isShowFAB) {
          setState(() {
            _isShowFAB = true;
          });
        }
      }

      _scrollController.addListener(temp);
      return () => _scrollController.removeListener(temp);
    }, []);
    return Scaffold(
      body: PageStateProvider(
        viewModel: mViewModel,
        onLoadRetry: () => mViewModel.wxArticleList(RequestType.page, widget.id),
        builder: (context) => Column(
          children: [
            SelectorWidget<WxChatViewModel, SelectorData<List<ArticleEntity>>>(
              selector: (context, _) => mViewModel.wxArticleEntityList,
              builder: (context, it, child) {
                return Expanded(
                  child: RefreshWidget(
                    viewModel: mViewModel,
                    onRefresh: () async => await mViewModel.wxArticleList(RequestType.refresh, widget.id),
                    onLoad: () async => await mViewModel.wxArticleList(RequestType.refresh, widget.id),
                    child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (context, index) {
                        return const Divider(thickness: 0.3, height: 0);
                      },
                      itemCount: it.value!.length,
                      itemBuilder: (context, index) {
                        return ArticleWidget(articleEntity: it.value![index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: !_isShowFAB
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                // 回到顶部时要执行的动画
                _scrollController.animateTo(0, duration: const Duration(milliseconds: 2000), curve: Curves.ease);
              },
            ),
    );
  }
}
