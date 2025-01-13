import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/constant/common_constant.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/page/main/view/login_page.dart';
import 'package:wanandroid_flutter/page/main/view/main_page.dart';
import 'package:wanandroid_flutter/page/main/view/my_collect_page.dart';
import 'package:wanandroid_flutter/page/main/view/my_points_page.dart';
import 'package:wanandroid_flutter/page/main/view/register_page.dart';
import 'package:wanandroid_flutter/page/main/view/webview_page.dart';

import '../res/m_string.dart';

final router = GoRouter(
  initialLocation: RouterConstant.MainPage,
  navigatorKey: CommonConstant.navKey,
  routes: [
    // main
    GoRoute(path: RouterConstant.MainPage, builder: (context, state) => const MainPage(), onExit: (context) => _isExit()),
    GoRoute(path: RouterConstant.WebViewPage, builder: (context, state) => const WebViewPage()),
    GoRoute(path: RouterConstant.MyPointsPage, builder: (context, state) => const MyPointsPage()),
    GoRoute(path: RouterConstant.MyCollectPage, builder: (context, state) => const MyCollectPage()),
    GoRoute(path: RouterConstant.LoginPage, builder: (context, state) => const LoginPage()),
    GoRoute(path: RouterConstant.RegisterPage, builder: (context, state) => const RegisterPage()),
  ],
);

DateTime? _lastTime;

Future<bool> _isExit() async {
  if (_lastTime == null || DateTime.now().difference(_lastTime!) > const Duration(milliseconds: 2500)) {
    _lastTime = DateTime.now();
    EasyLoading.showToast(MString.commonExit);
    return Future.value(false);
  }
  EasyLoading.dismiss();

  /// 不推荐使用 `dart:io` 的 exit(0)
  await SystemNavigator.pop();
  return Future.value(true);
}

//跳转界面
void goto(String location, {Object? extra, bool? needCloseCurrent}) {
  final goRouter = GoRouter.of(CommonConstant.navKey.currentState!.context);
  final GoRouterDelegate goRouterDelegate = goRouter.routerDelegate;

  var routes = goRouterDelegate.currentConfiguration.routes;
  var lastRouter = routes.last;

  if ((lastRouter as GoRoute).path != location) {
    needCloseCurrent != null && needCloseCurrent
        ? GoRouter.of(CommonConstant.navKey.currentState!.context).go(location, extra: extra)
        : GoRouter.of(CommonConstant.navKey.currentState!.context).push(location, extra: extra);
  }
}

/*
   * 关闭界面
   * predicate : 循环退回到的页面
   */
void finish({String? goback}) {
  final goRouter = GoRouter.of(CommonConstant.navKey.currentState!.context);
  final GoRouterDelegate goRouterDelegate = goRouter.routerDelegate;

  if (goback == null) {
    if (goRouterDelegate.canPop()) {
      goRouterDelegate.pop();
    }
    return;
  }

  var routes = goRouterDelegate.currentConfiguration.routes;
  var lastRouter = routes.last;

  while (goRouterDelegate.canPop()) {
    if (lastRouter is GoRoute) {
      if (lastRouter.path == goback) break;
      if (!goRouterDelegate.canPop()) break;
      goRouterDelegate.pop();
    }

    routes = goRouterDelegate.currentConfiguration.routes;
    lastRouter = routes.last;
  }
}

