import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/app_router.dart';
import 'package:wanandroid_flutter/base/init_config.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/ApiModule.dart';
import 'package:wanandroid_flutter/page/main/provider/locale_provider.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';
import 'package:wanandroid_flutter/res/m_string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //初始化配置
  initConfig();
  //初始化制造器
  initInjector();
  //初始化拦截器
  initDio();

  runApp(const MyApp());

  // 强制全局竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，
    // 是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // set your desired status bar color
      // statusBarIconBrightness: Brightness.dark, // set the status bar icon color
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (BuildContext context, LocaleProvider localeProvider, Widget? child) {
          //统一加入点击空白出收键盘
          return KeyboardDismissOnTap(
            child: MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              title: MString.appName,
              theme: ThemeData(
                // 全局移除水波纹效果
                  splashFactory: NoSplash.splashFactory,
                  // 全局移除点击高亮效果
                  highlightColor: Colors.transparent,
                  //应用程序主要部分的背景颜色(toolbars、tab bars 等)
                  primaryColor: MColors.appMain,
                  //Tab指示器颜色
                  indicatorColor: MColors.appMain,
                  //页面背景色
                  scaffoldBackgroundColor: MColors.bgColor,
                  //分割线主题
                  dividerTheme: const DividerThemeData(color: MColors.divider),
                  //应用栏主题
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.white), // 设置Drawer中图标的颜色
                    color: MColors.appMain,
                    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  //侧滑页面主题
                  drawerTheme: const DrawerThemeData(backgroundColor: MColors.white),
                  //选项卡主题
                  tabBarTheme: const TabBarTheme(
                    labelColor: MColors.white,
                    indicatorColor: MColors.white,
                    unselectedLabelColor: MColors.gray_66,
                    labelStyle: TextStyle(fontSize: 14),
                    unselectedLabelStyle: TextStyle(fontSize: 14),
                    dividerHeight: 0,
                  ),
                  //浮动按钮主题
                  floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: MColors.appMain, // 设置全局的背景色
                    foregroundColor: Colors.white, // 设置全局的前景色
                  ),
                  //底部导航栏主题
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    selectedItemColor: MColors.appMain,
                  ),
                  //取消长按控件信息
                  tooltipTheme: const TooltipThemeData(
                    decoration: BoxDecoration(), // 移除默认的装饰样式
                    textStyle: TextStyle(color: Colors.transparent), // 设置 tooltip 文本样式为空
                  ),
                  //按钮主题(ElevatedButton)
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MColors.appMain,
                      foregroundColor: MColors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // 设置圆角半径为10
                      ),
                    ),
                  ),
                  //按钮主题(TextButton)
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: MColors.appMain,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // 设置圆角半径为10
                      ),
                    ),
                  ),
                  //弹出框主题
                  dialogTheme: DialogTheme(
                    backgroundColor: MColors.white,
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), // 设置圆角半径为10
                    ),
                  )),
              // home: const MainPage(),
              builder: EasyLoading.init(),
            ),
          );
        },
      ),
    );
  }
}
