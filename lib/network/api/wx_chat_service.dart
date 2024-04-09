import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wanandroid_flutter/base/base_entity.dart';
import 'package:wanandroid_flutter/network/http_url_contant.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';

part 'wx_chat_service.g.dart';

@RestApi(baseUrl: HttpUrlContant.baseUrl)
abstract class WxChatService {
  factory WxChatService(Dio dio) = _WxChatService;

  @GET(HttpUrlContant.wxChapters)
  Future<BaseEntity<List<ChaptersEntity>>> wxArticleChapters();

  @GET(HttpUrlContant.wxArticleList)
  Future<BaseEntity<PagingEntity<ArticleEntity>>> wxArticleList(@Path("id") int id,@Path("pageNum") int pageNum);
}
