import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wanandroid_flutter/base/base_entity.dart';
import 'package:wanandroid_flutter/network/http_url_contant.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/home/model/banner_entity.dart';

part 'home_service.g.dart';

@RestApi(baseUrl: HttpUrlContant.baseUrl)
abstract class HomeService {
  factory HomeService(Dio dio) = _HomeService;

  @GET(HttpUrlContant.homeBanner)
  Future<BaseEntity<List<BannerEntity>>> banner();

  @GET(HttpUrlContant.articleTopJson)
  Future<BaseEntity<List<ArticleEntity>>> articleTopJson();

  @GET(HttpUrlContant.articleList)
  Future<BaseEntity<PagingEntity<ArticleEntity>>> articleList(@Path("pageNum") int pageNum);

}
