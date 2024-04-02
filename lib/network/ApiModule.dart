import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/home_service.dart';
import 'package:wanandroid_flutter/network/api/wx_chat_service.dart';
import 'package:wanandroid_flutter/network/api/project_service.dart';
import 'package:wanandroid_flutter/network/api/square_service.dart';
import 'package:wanandroid_flutter/network/api/system_service.dart';
import 'package:wanandroid_flutter/network/http_url_contant.dart';

@module
abstract class ApiModule {
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
      // client.findProxy = (uri) => 'PROXY 10.11.7.34:8888';
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  //拦截器
  // _interceptors();
}

// 获取拦截器
InterceptorsWrapper _interceptors() {
  return InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      print("请求之前 header = ${options.headers.toString()}");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(options);
    },
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      print("响应之前");
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(response); // continue
    },
    onError: (DioException e, ErrorInterceptorHandler handler) {
      // print("错误之前");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
    },
  );
}
