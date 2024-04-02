import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/page/main/view/main_page.dart';
import 'package:wanandroid_flutter/page/main/view/webview_page.dart';

final router = GoRouter(
  initialLocation: RouterConstant.main,
  routes: [
    // main
    GoRoute(path: RouterConstant.main, builder: (context, state) => const MainPage()),
    GoRoute(path: RouterConstant.webView, builder: (context, state) => const WebViewPage()),
  ],
);
