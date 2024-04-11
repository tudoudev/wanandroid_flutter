import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/widget/refresh_widget.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/router_helper.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/viewmodel/wxchat_view_model.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

class ArticlePage extends StatefulWidget {
  final int id;

  const ArticlePage({super.key, required this.id});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends BaseState<WxChatViewModel, ArticlePage> with AutomaticKeepAliveClientMixin {
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
                        return Divider(thickness: 0.3.w, height: 0);
                      },
                      itemCount: it.value!.length,
                      itemBuilder: (context, index) {
                        var item = it.value![index];
                        return InkWell(
                          onTap: () {
                            context.goto(RouterConstant.webViewPage, extra: {'url': item.link, 'title': item.title});
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
                                child: Row(
                                  children: [
                                    Visibility(
                                        visible: item.isTop,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: MColors.c_f44336, width: 0.5.w),
                                            borderRadius: BorderRadius.all(Radius.circular(2.w)),
                                          ),
                                          padding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
                                          margin: EdgeInsets.fromLTRB(0, 0, 4.w, 0),
                                          child: Text(StringUtil.get().homeText_1, style: TextStyle(fontSize: 10.sp, color: MColors.c_f44336)),
                                        )),
                                    Visibility(
                                        visible: item.fresh,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: MColors.c_f44336, width: 0.5.w),
                                            borderRadius: BorderRadius.all(Radius.circular(2.w)),
                                          ),
                                          padding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
                                          margin: EdgeInsets.fromLTRB(0, 0, 4.w, 0),
                                          child: Text(StringUtil.get().homeText_2, style: TextStyle(fontSize: 10.sp, color: MColors.c_f44336)),
                                        )),
                                    Visibility(
                                        visible: item.tags.isNotEmpty,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: MColors.c_a00bcd4, width: 0.5.w),
                                            borderRadius: BorderRadius.all(Radius.circular(2.w)),
                                          ),
                                          padding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
                                          margin: EdgeInsets.fromLTRB(0, 0, 4.w, 0),
                                          child: Text(item.tags.isNotEmpty ? item.tags[0].name : "", style: TextStyle(fontSize: 10.sp, color: MColors.c_a00bcd4)),
                                        )),
                                    Text(
                                      item.author.isNotEmpty ? item.author : item.shareUser,
                                      style: TextStyle(fontSize: 12.sp, color: MColors.gray_66),
                                      textAlign: TextAlign.left,
                                    ),
                                    Expanded(
                                      child: Text(
                                        item.niceDate,
                                        style: TextStyle(fontSize: 12.sp, color: MColors.gray_66),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                                child: Text(item.title, style: TextStyle(fontSize: 14.sp)),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
                                child: Row(
                                  children: [
                                    Text(
                                      "${item.superChapterName} / ${item.chapterName}",
                                      style: TextStyle(fontSize: 12.sp, color: MColors.gray_66),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.favorite_border,
                                      size: 22.w,
                                      color: MColors.gray_66,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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

  @override
  bool get wantKeepAlive => true;
}
