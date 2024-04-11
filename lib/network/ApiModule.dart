import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/init_config.dart';
import 'package:wanandroid_flutter/constant/cache_manager.dart';
import 'package:wanandroid_flutter/network/api/home_service.dart';
import 'package:wanandroid_flutter/network/api/main_service.dart';
import 'package:wanandroid_flutter/network/api/project_service.dart';
import 'package:wanandroid_flutter/network/api/square_service.dart';
import 'package:wanandroid_flutter/network/api/system_service.dart';
import 'package:wanandroid_flutter/network/api/wx_chat_service.dart';
import 'package:wanandroid_flutter/network/http_url_contant.dart';
import 'package:wanandroid_flutter/util/sp_util.dart';

@module
abstract class ApiModule {
  MainService provideMainService() {
    final client = MainService(dio);
    return client;
  }

  HomeService provideHomeService() {
    final client = HomeService(dio);
    return client;
  }

  SquareService provideSquareService() {
    final client = SquareService(dio);
    return client;
  }

  WxChatService provideOfficialAccountService() {
    final client = WxChatService(dio);
    return client;
  }

  SystemService provideSystemService() {
    final client = SystemService(dio);
    return client;
  }

  ProjectService provideProjectService() {
    final client = ProjectService(dio);
    return client;
  }
}

Dio dio = Dio(
  BaseOptions(
    baseUrl: HttpUrlContant.baseUrl,
    connectTimeout: const Duration(milliseconds: 20 * 1000),
    receiveTimeout: const Duration(milliseconds: 20 * 1000),
  ),
);

void initDio() {
  //httpClient
  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (client) {
      // if (kDebugMode) client.findProxy = (uri) => 'PROXY 10.11.4.143:8888';
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  //拦截器
  dio.interceptors.add(_interceptors());
}

// 获取拦截器
InterceptorsWrapper _interceptors() {
  return InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // print("请求之前 header = ${options.headers.toString()}");

      //设置cookie
      options.headers[HttpHeaders.cookieHeader] = CacheManager.instance.getCookies();
      return handler.next(options);
    },
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      // print("响应之前");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。

      //登录响应
      if (response.requestOptions.uri.toString().contains(HttpUrlContant.login)) {
        var cookies = response.headers[HttpHeaders.setCookieHeader];
        if (cookies != null) {
          CacheManager.instance.setCookies(cookies);
        }
      }
      return handler.next(response); // continue
    },
    onError: (DioException e, ErrorInterceptorHandler handler) {
      // print("错误之前");
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。

      logger.i(e.message);
      handler.next(e);
    },
  );
}
