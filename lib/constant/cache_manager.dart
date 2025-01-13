import 'dart:convert';

import 'package:wanandroid_flutter/constant/common_constant.dart';
import 'package:wanandroid_flutter/page/main/model/user_info_entity.dart';
import 'package:wanandroid_flutter/util/common_util.dart';
import 'package:wanandroid_flutter/util/sp_util.dart';

class CacheManager {
  // 私有构造函数，防止外部实例化
  CacheManager._();

  // 单例实例
  static final CacheManager _instance = CacheManager._();

  // 获取单例实例的方法
  static CacheManager get instance => _instance;

  static const KEY_USER_COOKIES = "KEY_USER_COOKIES"; //用户cookies
  static const KEY_USER_INFO = "KEY_USER_INFO"; //用户信息

  List<String>? cookies;
  late UserInfoEntity userInfoEntity;

  //设置cookies
  void setCookies(List<String> list) {
    cookies = list;
    SpUtil.putStringList(KEY_USER_COOKIES, list);
  }

  //获取cookies
  List<String>? getCookies() {
    cookies ??= SpUtil.getStringList(KEY_USER_COOKIES);
    return cookies;
  }

  /*
   * 移除用户信息
   */
  removeUserInfo() {
    userInfoEntity = UserInfoEntity();
    SpUtil.remove(KEY_USER_INFO);
  }

  /*
   * 设置用户信息
   */
  setUserInfo(UserInfoEntity bean) {
    userInfoEntity = bean;
    SpUtil.putObject(KEY_USER_INFO, bean);
  }

  /*
   * 获取用户信息
   */
  UserInfoEntity getUserInfo() {
    userInfoEntity = UserInfoEntity();
    if (isLateInitialized(() => userInfoEntity)) {
      return SpUtil.getObject(KEY_USER_INFO) != null ? UserInfoEntity.fromJson(SpUtil.getObject(KEY_USER_INFO)!) : UserInfoEntity();
    } else {
      return userInfoEntity;
    }
  }
}
