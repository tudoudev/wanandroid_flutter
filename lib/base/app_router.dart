import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/constant/common_constant.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/page/main/view/login_page.dart';
import 'package:wanandroid_flutter/page/main/view/main_page.dart';
import 'package:wanandroid_flutter/page/main/view/my_points_page.dart';
import 'package:wanandroid_flutter/page/main/view/register_page.dart';
import 'package:wanandroid_flutter/page/main/view/splash_page.dart';
import 'package:wanandroid_flutter/page/main/view/webview_page.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

final router = GoRouter(
  initialLocation: RouterConstant.splashPage,
  navigatorKey: CommonConstant.navKey,
  routes: [
    // main
    GoRoute(path: RouterConstant.splashPage, builder: (context, state) => const SplashPage()),
    GoRoute(path: RouterConstant.mainPage, builder: (context, state) => const MainPage(), onExit: (context) => _isExit()),
    GoRoute(path: RouterConstant.webViewPage, builder: (context, state) => const WebViewPage()),
    GoRoute(path: RouterConstant.myPointsPage, builder: (context, state) => const MyPointsPage()),
    GoRoute(path: RouterConstant.loginPage, builder: (context, state) => const LoginPage()),
    GoRoute(path: RouterConstant.registerPage, builder: (context, state) => const RegisterPage()),
  ],
);

DateTime? _lastTime;

Future<bool> _isExit() async {
  if (_lastTime == null || DateTime.now().difference(_lastTime!) > const Duration(milliseconds: 2500)) {
    _lastTime = DateTime.now();
    EasyLoading.showToast(StringUtil.get().commonExit);
    return Future.value(false);
  }
  EasyLoading.dismiss();

  /// 不推荐使用 `dart:io` 的 exit(0)
  await SystemNavigator.pop();
  return Future.value(true);
}
