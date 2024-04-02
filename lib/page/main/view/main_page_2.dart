// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wanandroid_flutter/base/base_state.dart';
// import 'package:wanandroid_flutter/base/selector_widget.dart';
// import 'package:wanandroid_flutter/page/home/view/home_page.dart';
// import 'package:wanandroid_flutter/page/main/viewmodel/main_view_model.dart';
// import 'package:wanandroid_flutter/page/official_accounts/view/wxchat_page.dart';
// import 'package:wanandroid_flutter/page/project/view/project_page.dart';
// import 'package:wanandroid_flutter/page/square/view/square_page.dart';
// import 'package:wanandroid_flutter/page/system/view/system_page.dart';
// import 'package:wanandroid_flutter/res/strings.dart';
//
// /*
//  * Description：<main>
//  * Created by：zzl
//  * Time：2024/3/7  15:07
//  */
// class MainPage2 extends StatefulWidget {
//   const MainPage2({super.key});
//
//   @override
//   State<MainPage2> createState() => _MainPageState2();
// }
//
// class _MainPageState2 extends BaseState<MainViewModel, MainPage2> {
//   final _pageController = PageController();
//
//   final _pages = [
//     const HomePage(),
//     const SquarePage(),
//     const OfficialAccountsPage(),
//     const SystemPage(),
//     const ProjectPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     var a = MainViewModel();
//     a.aaa = 10;
//     return ChangeNotifierProvider.value(
//       value: a,
//       builder: (context, child) => Scaffold(
//         body: PageView.builder(
//             controller: _pageController,
//             itemCount: _pages.length,
//             itemBuilder: (BuildContext context, int index) {
//               return _pages[Provider.of<MainViewModel>(context).selectIndex];
//             }),
//         bottomNavigationBar: BottomNavigationBar(
//           //显示模式
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: MStrings.text_1,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.sports_gymnastics),
//               label: MStrings.text_2,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.wechat),
//               label: MStrings.text_3,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.sports_volleyball),
//               label: MStrings.text_4,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.apps),
//               label: MStrings.text_5,
//             )
//           ],
//           //当前选中下标
//           currentIndex: Provider.of<MainViewModel>(context).selectIndex,
//           //点击事件
//           onTap: (index) {
//             Provider.of<MainViewModel>(context, listen: false).changeSelectIndex(index);
//             _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
//           },
//         ),
//       ),
//     );
//   }
//
//   void _onItemTapped(int index) {
//     Provider.of<MainViewModel>(context, listen: false).changeSelectIndex(index);
//     //bottomNavigationBar 和 PageView 关联
//     _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
//   }
// }
