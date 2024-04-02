import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

extension RouterHelper on BuildContext {
  //跳转新界面(顶部不重复)
  void goto(String location, {Object? extra}) {
    final goRouter = GoRouter.of(this);
    final GoRouterDelegate goRouterDelegate = goRouter.routerDelegate;

    var routes = goRouterDelegate.currentConfiguration.routes;
    var lastRouter = routes.last;

    if ((lastRouter as GoRoute).path != location) {
      GoRouter.of(this).push(location, extra: extra);
    }
  }

  /*
   * 关闭界面
   * predicate : 循环退回到的页面
   */
  void finish({String? goback}) {
    final goRouter = GoRouter.of(this);
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
}
