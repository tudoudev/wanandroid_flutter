import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/base/multi_state_widget.dart';
import 'package:wanandroid_flutter/base/refresh_widget.dart';
import 'package:wanandroid_flutter/base/selector_widget.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/router_helper.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/viewmodel/wxchat_view_model.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widget/custom_network_image.dart';

class ProjectArticlePage extends StatefulWidget {
  final int id;

  const ProjectArticlePage({super.key, required this.id});

  @override
  State<ProjectArticlePage> createState() => _ProjectArticlePageState();
}

class _ProjectArticlePageState extends BaseState<WxChatViewModel, ProjectArticlePage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  // 是否显示悬浮按钮
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    //初始化view
    mViewModel.wxArticleList(RequestType.page, widget.id);
    //listview滚动监听
    _scrollController.addListener(() {
      if (_scrollController.offset < 200 && _isShowFAB) {
        setState(() {
          _isShowFAB = false;
        });
      } else if (_scrollController.offset >= 200 && !_isShowFAB) {
        setState(() {
          _isShowFAB = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (_) => mViewModel,
          child: SelectorWidget<WxChatViewModel, PageState>(
              selector: (context, _) => mViewModel.pageState,
              builder: (context, it, child) {
                return PageStateWidget(
                  pageState: mViewModel.pageState,
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
                                  return Divider(thickness: 0.3.w, height: 0);
                                },
                                itemCount: it.value!.length,
                                itemBuilder: (context, index) {
                                  var item = it.value![index];
                                  return InkWell(
                                    onTap: () {
                                      context.goto(RouterConstant.webView, extra: {'url': item.link, 'title': item.title});
                                    },
                                    child: Row(children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(16.w, 8.w, 8.w, 8.w),
                                        height: 130.w,
                                        width: 80.w,
                                        child: CustomNetworkImage(imageUrl: item.envelopePic),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(8.w, 8.w, 16.w, 0.w),
                                              child: Text(
                                                item.title,
                                                style: TextStyle(fontSize: 14.sp),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(8.w, 8.w, 16.w, 0.w),
                                              child: Text(
                                                item.desc,
                                                style: TextStyle(fontSize: 12.sp, color: MColors.gray_66),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(8.w, 8.w, 16.w, 0.w),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    item.author.isNotEmpty ? item.author : item.shareUser,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: MColors.gray_66,
                                                    ),
                                                  ),
                                                  Text(
                                                    item.niceDate,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: MColors.gray_66,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
                                              alignment: const Alignment(1, 0),
                                              child: Icon(
                                                Icons.favorite_border,
                                                size: 22.w,
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
                );
              })),
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

  @override
  bool get wantKeepAlive => true;
}
