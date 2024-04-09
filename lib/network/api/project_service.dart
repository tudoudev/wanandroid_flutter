import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wanandroid_flutter/base/base_entity.dart';
import 'package:wanandroid_flutter/network/http_url_contant.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';

part 'project_service.g.dart';

@RestApi(baseUrl: HttpUrlContant.baseUrl)
abstract class ProjectService {
  factory ProjectService(Dio dio) = _ProjectService;

  @GET(HttpUrlContant.projectTreeJson)
  Future<BaseEntity<List<ChaptersEntity>>> projectTreeJson();

}
