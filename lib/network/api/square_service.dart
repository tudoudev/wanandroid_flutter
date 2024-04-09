import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wanandroid_flutter/base/base_entity.dart';
import 'package:wanandroid_flutter/network/http_url_contant.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';

part 'square_service.g.dart';

@RestApi(baseUrl: HttpUrlContant.baseUrl)
abstract class SquareService {
  factory SquareService(Dio dio) = _SquareService;

  @GET(HttpUrlContant.userArticleList)
  Future<BaseEntity<PagingEntity<ArticleEntity>>> userArticleList(@Path("pageNum") int pageNum);
}
