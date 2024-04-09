import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/l10n1.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/app_router.dart';
import 'package:wanandroid_flutter/base/init_config.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/ApiModule.dart';
import 'package:wanandroid_flutter/page/main/provider/locale_provider.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/res/dimens.dart';

void main() {
  //初始化配置
  initConfig();
  //初始化制造器
  initInjector();
  //初始化拦截器
  initDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (BuildContext context, LocaleProvider localeProvider, Widget? child) {
          return ScreenUtilInit(
            designSize: const Size(375, 667),
            minTextAdapt: true, //是否根据宽度/高度中的最小值适配文字
            builder: (context, child) {
              return MaterialApp.router(
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: localeProvider.locale,
                onGenerateTitle: (context) {
                  return AppLocalizations.of(context)!.appName;
                },
                theme: ThemeData(
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
                    titleTextStyle: TextStyle(color: Colors.white, fontSize: MDimens.font_sp20),
                  ),
                  //侧滑页面主题
                  drawerTheme: const DrawerThemeData(backgroundColor: MColors.white),
                  //选项卡主题
                  tabBarTheme: TabBarTheme(
                    labelColor: MColors.white,
                    indicatorColor: MColors.white,
                    unselectedLabelColor: MColors.gray_66,
                    labelStyle: TextStyle(fontSize: 14.w),
                    unselectedLabelStyle: TextStyle(fontSize: 14.w),
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
                ),
                // home: const MainPage(),
                builder: EasyLoading.init(),
              );
            },
          );
        },
      ),
    );
  }
}
