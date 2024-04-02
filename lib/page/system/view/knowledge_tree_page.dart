import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/base/multi_state_widget.dart';
import 'package:wanandroid_flutter/base/refresh_widget.dart';
import 'package:wanandroid_flutter/base/selector_widget.dart';
import 'package:wanandroid_flutter/page/system/viewmodel/system_view_model.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';
import 'package:wanandroid_flutter/res/colors.dart';

class KnowledgeTreePage extends StatefulWidget {
  const KnowledgeTreePage({super.key});

  @override
  State<KnowledgeTreePage> createState() => _KnowledgeTreePageState();
}

class _KnowledgeTreePageState extends BaseState<SystemViewModel, KnowledgeTreePage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  // 是否显示悬浮按钮
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    //初始化view
    mViewModel.treeJson(RequestType.page);
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
          child: SelectorWidget<SystemViewModel, PageState>(
              selector: (context, _) => mViewModel.pageState,
              builder: (context, it, child) {
                return PageStateWidget(
                  pageState: mViewModel.pageState,
                  onLoadRetry: () => mViewModel.treeJson(RequestType.page),
                  builder: (context) => Column(
                    children: [
                      SelectorWidget<SystemViewModel, SelectorData<List<ChaptersEntity>>>(
                        selector: (context, _) => mViewModel.chaptersEntityList,
                        builder: (context, it, child) {
                          return Expanded(
                            child: RefreshWidget(
                              viewModel: mViewModel,
                              onRefresh: () async => await mViewModel.treeJson(RequestType.refresh),
                              child: ListView.separated(
                                controller: _scrollController,
                                separatorBuilder: (context, index) {
                                  return Divider(thickness: 0.3.w, height: 0);
                                },
                                itemCount: it.value!.length,
                                itemBuilder: (context, index) {
                                  var item = it.value![index];
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(bottom: 8.w),
                                                child: Text(
                                                  item.name,
                                                  style: TextStyle(fontSize: 15.sp),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Wrap(
                                                  spacing: 10.w,
                                                  runSpacing: 6.w,
                                                  children: item.children
                                                      .map((e) => Text(
                                                            e.name,
                                                            style: const TextStyle(color: MColors.gray_66),
                                                          ))
                                                      .toList(),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
                                        child: const Icon(
                                          Icons.chevron_right,
                                          color: MColors.gray_99,
                                        ),
                                      )
                                    ],
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
