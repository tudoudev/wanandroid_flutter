// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `wanandroid`
  String get appName {
    return Intl.message(
      'wanandroid',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `上拉加载`
  String get commonDragText {
    return Intl.message(
      '上拉加载',
      name: 'commonDragText',
      desc: '',
      args: [],
    );
  }

  /// `再次点击退出应用`
  String get commonExit {
    return Intl.message(
      '再次点击退出应用',
      name: 'commonExit',
      desc: '',
      args: [],
    );
  }

  /// `失败了`
  String get commonFailedText {
    return Intl.message(
      '失败了',
      name: 'commonFailedText',
      desc: '',
      args: [],
    );
  }

  /// `加载失败，点击重试`
  String get commonLoadingFailed {
    return Intl.message(
      '加载失败，点击重试',
      name: 'commonLoadingFailed',
      desc: '',
      args: [],
    );
  }

  /// `网络失联了…\n请联网后点击重试`
  String get commonLoadingNoNetWork {
    return Intl.message(
      '网络失联了…\\n请联网后点击重试',
      name: 'commonLoadingNoNetWork',
      desc: '',
      args: [],
    );
  }

  /// `--`
  String get commonNoData {
    return Intl.message(
      '--',
      name: 'commonNoData',
      desc: '',
      args: [],
    );
  }

  /// `确定`
  String get commonOk {
    return Intl.message(
      '确定',
      name: 'commonOk',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get commonCancel {
    return Intl.message(
      '取消',
      name: 'commonCancel',
      desc: '',
      args: [],
    );
  }

  /// `没有更多数据了`
  String get commonNoMoreText {
    return Intl.message(
      '没有更多数据了',
      name: 'commonNoMoreText',
      desc: '',
      args: [],
    );
  }

  /// `网络无连接,请检查网络`
  String get commonNoNetWork {
    return Intl.message(
      '网络无连接,请检查网络',
      name: 'commonNoNetWork',
      desc: '',
      args: [],
    );
  }

  /// `服务器繁忙，请稍后再试`
  String get commonOnFailure {
    return Intl.message(
      '服务器繁忙，请稍后再试',
      name: 'commonOnFailure',
      desc: '',
      args: [],
    );
  }

  /// `成功了`
  String get commonProcessedText {
    return Intl.message(
      '成功了',
      name: 'commonProcessedText',
      desc: '',
      args: [],
    );
  }

  /// `加载中...`
  String get commonReadyText {
    return Intl.message(
      '加载中...',
      name: 'commonReadyText',
      desc: '',
      args: [],
    );
  }

  /// `首页`
  String get commonText_1 {
    return Intl.message(
      '首页',
      name: 'commonText_1',
      desc: '',
      args: [],
    );
  }

  /// `广场`
  String get commonText_2 {
    return Intl.message(
      '广场',
      name: 'commonText_2',
      desc: '',
      args: [],
    );
  }

  /// `公众号`
  String get commonText_3 {
    return Intl.message(
      '公众号',
      name: 'commonText_3',
      desc: '',
      args: [],
    );
  }

  /// `体系`
  String get commonText_4 {
    return Intl.message(
      '体系',
      name: 'commonText_4',
      desc: '',
      args: [],
    );
  }

  /// `项目`
  String get commonText_5 {
    return Intl.message(
      '项目',
      name: 'commonText_5',
      desc: '',
      args: [],
    );
  }

  /// `导航`
  String get commonText_6 {
    return Intl.message(
      '导航',
      name: 'commonText_6',
      desc: '',
      args: [],
    );
  }

  /// `置顶`
  String get homeText_1 {
    return Intl.message(
      '置顶',
      name: 'homeText_1',
      desc: '',
      args: [],
    );
  }

  /// `新`
  String get homeText_2 {
    return Intl.message(
      '新',
      name: 'homeText_2',
      desc: '',
      args: [],
    );
  }

  /// `去登录`
  String get main_1 {
    return Intl.message(
      '去登录',
      name: 'main_1',
      desc: '',
      args: [],
    );
  }

  /// `等级:`
  String get main_2 {
    return Intl.message(
      '等级:',
      name: 'main_2',
      desc: '',
      args: [],
    );
  }

  /// `排名:`
  String get main_3 {
    return Intl.message(
      '排名:',
      name: 'main_3',
      desc: '',
      args: [],
    );
  }

  /// `我的积分`
  String get main_4 {
    return Intl.message(
      '我的积分',
      name: 'main_4',
      desc: '',
      args: [],
    );
  }

  /// `我的收藏`
  String get main_5 {
    return Intl.message(
      '我的收藏',
      name: 'main_5',
      desc: '',
      args: [],
    );
  }

  /// `我的分享`
  String get main_6 {
    return Intl.message(
      '我的分享',
      name: 'main_6',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get main_7 {
    return Intl.message(
      '登录',
      name: 'main_7',
      desc: '',
      args: [],
    );
  }

  /// `用户登录`
  String get main_8 {
    return Intl.message(
      '用户登录',
      name: 'main_8',
      desc: '',
      args: [],
    );
  }

  /// `请使用WanAndroid账号登录`
  String get main_9 {
    return Intl.message(
      '请使用WanAndroid账号登录',
      name: 'main_9',
      desc: '',
      args: [],
    );
  }

  /// `用户名`
  String get main_10 {
    return Intl.message(
      '用户名',
      name: 'main_10',
      desc: '',
      args: [],
    );
  }

  /// `请输入用户名`
  String get main_11 {
    return Intl.message(
      '请输入用户名',
      name: 'main_11',
      desc: '',
      args: [],
    );
  }

  /// `密码`
  String get main_12 {
    return Intl.message(
      '密码',
      name: 'main_12',
      desc: '',
      args: [],
    );
  }

  /// `请输入密码`
  String get main_13 {
    return Intl.message(
      '请输入密码',
      name: 'main_13',
      desc: '',
      args: [],
    );
  }

  /// `还没有账号，注册一个？`
  String get main_14 {
    return Intl.message(
      '还没有账号，注册一个？',
      name: 'main_14',
      desc: '',
      args: [],
    );
  }

  /// `注册`
  String get main_15 {
    return Intl.message(
      '注册',
      name: 'main_15',
      desc: '',
      args: [],
    );
  }

  /// `注册用户`
  String get main_16 {
    return Intl.message(
      '注册用户',
      name: 'main_16',
      desc: '',
      args: [],
    );
  }

  /// `用户注册后才可以登录`
  String get main_17 {
    return Intl.message(
      '用户注册后才可以登录',
      name: 'main_17',
      desc: '',
      args: [],
    );
  }

  /// `再次输入密码`
  String get main_18 {
    return Intl.message(
      '再次输入密码',
      name: 'main_18',
      desc: '',
      args: [],
    );
  }

  /// `请再次输入密码`
  String get main_19 {
    return Intl.message(
      '请再次输入密码',
      name: 'main_19',
      desc: '',
      args: [],
    );
  }

  /// `注册成功`
  String get main_20 {
    return Intl.message(
      '注册成功',
      name: 'main_20',
      desc: '',
      args: [],
    );
  }

  /// `登录成功`
  String get main_21 {
    return Intl.message(
      '登录成功',
      name: 'main_21',
      desc: '',
      args: [],
    );
  }

  /// `退出登录`
  String get main_22 {
    return Intl.message(
      '退出登录',
      name: 'main_22',
      desc: '',
      args: [],
    );
  }

  /// `确定退出登录吗?`
  String get main_23 {
    return Intl.message(
      '确定退出登录吗?',
      name: 'main_23',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
