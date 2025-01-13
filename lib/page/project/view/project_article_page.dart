import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wanandroid_flutter/base/app_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_state_keep_alive.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/widget/refresh_widget.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/viewmodel/wxchat_view_model.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';
import 'package:wanandroid_flutter/widget/custom_network_image.dart';

class ProjectArticlePage extends StatefulHookWidget {
  final int id;

  const ProjectArticlePage({super.key, required this.id});

  @override
  State<ProjectArticlePage> createState() => _ProjectArticlePageState();
}

class _ProjectArticlePageState extends BaseStateKeepAlive<WxChatViewModel, ProjectArticlePage> {
  late ScrollController _scrollController;

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
                        var item = it.value![index];
                        return InkWell(
                          onTap: () {
                            goto(RouterConstant.WebViewPage, extra: {'url': item.link, 'title': item.title});
                          },
                          child: Row(children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                              height: 130,
                              width: 80,
                              child: CustomNetworkImage(imageUrl: item.envelopePic),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                                    child: Text(
                                      item.title,
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                                    child: Text(
                                      item.desc,
                                      style: const TextStyle(fontSize: 12, color: MColors.gray_66),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          item.author.isNotEmpty ? item.author : item.shareUser,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: MColors.gray_66,
                                          ),
                                        ),
                                        Text(
                                          item.niceDate,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: MColors.gray_66,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                    alignment: const Alignment(1, 0),
                                    child: Icon(
                                      context.watch<WxChatViewModel>().articleEntity.collect ? Icons.favorite : Icons.favorite_border,
                                      size: 22,
                                      color: MColors.gray_66,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        );
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
