import 'dart:convert';

import 'package:wanandroid_flutter/constant/common_constant.dart';
import 'package:wanandroid_flutter/page/main/model/user_info_entity.dart';
import 'package:wanandroid_flutter/util/sp_util.dart';

class CacheManager {
  // 私有构造函数，防止外部实例化
  CacheManager._();

  // 单例实例
  static final CacheManager _instance = CacheManager._();

  // 获取单例实例的方法
  static CacheManager get instance => _instance;

  List<String>? cookies;
  UserInfoEntity? userInfoEntity;

  //设置cookies
  void setCookies(List<String> list) {
    cookies = list;
    SpUtil.putStringList(CommonConstant.keyCookies, list);
  }

  //获取cookies
  List<String>? getCookies() {
    cookies ??= SpUtil.getStringList(CommonConstant.keyCookies);
    return cookies;
  }

  //设置用户
  void setUserInfo(UserInfoEntity entity) {
    userInfoEntity = entity;
    SpUtil.putObject(CommonConstant.keyUserInfo, entity);
  }

  //获取cookies
  UserInfoEntity? getUserInfo() {
    userInfoEntity ??= SpUtil.getObj(CommonConstant.keyUserInfo, (v) => UserInfoEntity.fromJson(v));
    return userInfoEntity;
  }

  //清除用户信息
  void clearUserInfo() {
    cookies = null;
    userInfoEntity = null;
    SpUtil.remove(CommonConstant.keyCookies);
    SpUtil.remove(CommonConstant.keyUserInfo);
  }
}
