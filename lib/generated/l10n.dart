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
