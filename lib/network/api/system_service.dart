import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wanandroid_flutter/base/base_entity.dart';
import 'package:wanandroid_flutter/network/http_url_contant.dart';
import 'package:wanandroid_flutter/page/system/model/navigation_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';

part 'system_service.g.dart';

@RestApi(baseUrl: HttpUrlContant.baseUrl)
abstract class SystemService {
  factory SystemService(Dio dio) = _SystemService;

  @GET(HttpUrlContant.treeJson)
  Future<BaseEntity<List<ChaptersEntity>>> treeJson();

  @GET(HttpUrlContant.naviJson)
  Future<BaseEntity<List<NavigationEntity>>> naviJson();
}
