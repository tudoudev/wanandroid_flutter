import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/page/home/view/home_page.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/main_view_model.dart';
import 'package:wanandroid_flutter/page/project/view/project_page.dart';
import 'package:wanandroid_flutter/page/square/view/square_page.dart';
import 'package:wanandroid_flutter/page/system/view/system_page.dart';
import 'package:wanandroid_flutter/page/wxchat/view/wxchat_page.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

/*
 * Description：<main>
 * Created by：zzl
 * Time：2024/3/7  15:07
 */
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainViewModel, MainPage> {
  final _pageController = PageController();

  final _pages = [
    const HomePage(),
    const SquarePage(),
    const WxChatPage(),
    const SystemPage(),
    const ProjectPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => mViewModel,
      child: SelectorWidget<MainViewModel, int>(
        selector: (context, _) => mViewModel.selectIndex,
        builder: (context, it, child) {
          return Scaffold(
            body: PageView.builder(
                onPageChanged: _pageChange,
                controller: _pageController,
                itemCount: _pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index];
                }),
            bottomNavigationBar: BottomNavigationBar(
              //显示模式
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: StringUtil.get().commonText_1,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.sports_gymnastics),
                  label: StringUtil.get().commonText_2,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.wechat),
                  label: StringUtil.get().commonText_3,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.sports_volleyball),
                  label: StringUtil.get().commonText_4,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.apps),
                  label: StringUtil.get().commonText_5,
                )
              ],
              //当前选中下标
              currentIndex: it,
              //点击事件
              onTap: _onItemTapped,
            ),
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    mViewModel.changeSelectIndex(index);
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _pageChange(int index) {
    mViewModel.changeSelectIndex(index);
  }
}
