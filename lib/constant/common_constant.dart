import 'package:flutter/cupertino.dart';

class CommonConstant {
  static var initialPageNum = 0; //请求页码-初始值
  static var pageSize = 10; //请求条数
  static const String locale = 'locale'; //语言
  static final navKey = GlobalKey<NavigatorState>(); //全局key

  static const String keyCookies = 'keyCookies';
  static const String keyUserInfo = 'keyUserInfo';
}
