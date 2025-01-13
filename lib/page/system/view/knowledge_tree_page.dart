import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/widget/refresh_widget.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/page/system/viewmodel/system_view_model.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';

class KnowledgeTreePage extends StatefulHookWidget {
  const KnowledgeTreePage({super.key});

  @override
  State<KnowledgeTreePage> createState() => _KnowledgeTreePageState();
}

class _KnowledgeTreePageState extends BaseState<SystemViewModel, KnowledgeTreePage> {
  late ScrollController _scrollController ;

  // 是否显示悬浮按钮
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    //初始化view
    mViewModel.treeJson(RequestType.page);
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
                        return const Divider(thickness: 0.3, height: 0);
                      },
                      itemCount: it.value!.length,
                      itemBuilder: (context, index) {
                        var item = it.value![index];
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 6,
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
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Icon(
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
