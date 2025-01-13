import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wanandroid_flutter/base/app_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/widget/refresh_widget.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/page/system/model/navigation_entity.dart';
import 'package:wanandroid_flutter/page/system/viewmodel/system_view_model.dart';

class NavigationPage extends StatefulHookWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends BaseState<SystemViewModel, NavigationPage> {
  late ScrollController _scrollController;

  // 是否显示悬浮按钮
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    //初始化view
    mViewModel.naviJson(RequestType.page);
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
        onLoadRetry: () => mViewModel.naviJson(RequestType.page),
        builder: (context) => Column(
          children: [
            SelectorWidget<SystemViewModel, SelectorData<List<NavigationEntity>>>(
              selector: (context, _) => mViewModel.navigationEntityList,
              builder: (context, it, child) {
                return Expanded(
                  child: RefreshWidget(
                    viewModel: mViewModel,
                    onRefresh: () async => await mViewModel.naviJson(RequestType.refresh),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(thickness: 0.3, height: 0);
                      },
                      controller: _scrollController,
                      itemCount: it.value!.length,
                      itemBuilder: (context, index) {
                        var item = it.value![index];
                        return Padding(
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
                                  spacing: 2,
                                  children: item.articles
                                      .map((e) => InkWell(
                                            onTap: () {
                                              goto(RouterConstant.WebViewPage, extra: {'url': e.link, 'title': e.title});
                                            },
                                            child: Chip(
                                              label: Text(
                                                e.title,
                                                style: TextStyle(
                                                    fontSize: 10, color: Color.fromARGB(255, Random().nextInt(190), Random().nextInt(190), Random().nextInt(190)), fontStyle: FontStyle.italic),
                                              ),
                                              labelPadding: const EdgeInsets.only(left: 2, right: 2),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
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
}
