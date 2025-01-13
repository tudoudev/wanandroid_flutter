import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/page/main/view/drawer_page.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/page/home/view/home_page.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/main_view_model.dart';
import 'package:wanandroid_flutter/page/project/view/project_page.dart';
import 'package:wanandroid_flutter/page/square/view/square_page.dart';
import 'package:wanandroid_flutter/page/system/view/system_page.dart';
import 'package:wanandroid_flutter/page/wxchat/view/wxchat_page.dart';

import '../../../res/m_string.dart';

/*
 * Description：<main>
 * Created by：zzl
 * Time：2024/3/7  15:07
 */
class MainPage extends StatefulHookWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainViewModel, MainPage> {
  late PageController _pageController;
  String title = MString.commonText_1;

  final _pages = [
    const HomePage(),
    const SquarePage(),
    const WxChatPage(),
    const SystemPage(),
    const ProjectPage(),
  ];

  @override
  Widget initView(BuildContext context) {
    _pageController = usePageController();
    return SelectorWidget<MainViewModel, int>(
      selector: (context, _) => mViewModel.selectIndex,
      builder: (context, it, child) {
        return Scaffold(
          drawer: const DrawerScreen(),
          appBar: AppBar(
            title: Text(title),
          ),
          body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: _pageChange,
              controller: _pageController,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index];
              }),
          bottomNavigationBar: BottomNavigationBar(
            //显示模式
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: MString.commonText_1,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_gymnastics),
                label: MString.commonText_2,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wechat),
                label: MString.commonText_3,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_volleyball),
                label: MString.commonText_4,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: MString.commonText_5,
              )
            ],
            //当前选中下标
            currentIndex: it,
            //点击事件
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    //修改标题
    switch (index) {
      case 0:
        title = MString.commonText_1;
      case 1:
        title = MString.commonText_2;
      case 2:
        title = MString.commonText_3;
      case 3:
        title = MString.commonText_4;
      case 4:
        title = MString.commonText_5;
    }
    //更新
    mViewModel.changeSelectIndex(index);
    //跳转
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _pageChange(int index) {
    mViewModel.changeSelectIndex(index);
  }
}
