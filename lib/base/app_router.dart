import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/page/main/view/main_page.dart';
import 'package:wanandroid_flutter/page/main/view/webview_page.dart';
import 'package:wanandroid_flutter/res/strings.dart';

final router = GoRouter(
  initialLocation: RouterConstant.main,
  routes: [
    // main
    GoRoute(path: RouterConstant.main, builder: (context, state) => const MainPage(), onExit: (context) => _isExit()),
    GoRoute(path: RouterConstant.webView, builder: (context, state) => const WebViewPage()),
  ],
);

DateTime? _lastTime;

Future<bool> _isExit() async {
  if (_lastTime == null || DateTime.now().difference(_lastTime!) > const Duration(milliseconds: 2500)) {
    _lastTime = DateTime.now();
    EasyLoading.showToast(MStrings.commonExit);
    return Future.value(false);
  }
  EasyLoading.dismiss();

  /// 不推荐使用 `dart:io` 的 exit(0)
  await SystemNavigator.pop();
  return Future.value(true);
}
