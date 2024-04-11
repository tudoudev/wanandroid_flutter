import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wanandroid_flutter/base/base_entity.dart';
import 'package:wanandroid_flutter/network/http_url_contant.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/home/model/banner_entity.dart';
import 'package:wanandroid_flutter/page/main/model/user_info_entity.dart';

part 'main_service.g.dart';

@RestApi(baseUrl: HttpUrlContant.baseUrl)
abstract class MainService {
  factory MainService(Dio dio) = _MainService;

  @GET(HttpUrlContant.lgCoinList)
  Future<BaseEntity<PagingEntity<ArticleEntity>>> lgCoinList(@Path("pageNum") int pageNum);

  @POST(HttpUrlContant.login)
  Future<BaseEntity<UserInfoEntity>> login(@Body() FormData map);

  @POST(HttpUrlContant.register)
  Future<BaseEntity<dynamic>> register(@Body() FormData map);
}
