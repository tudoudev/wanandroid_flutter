import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/constant/common_constant.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/home_service.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/home/model/banner_entity.dart';

@injectable
class HomeViewModel extends BaseViewModel {
  var bannerEntityList = SelectorData<List<BannerEntity>>(value: []);
  var articleEntityList = SelectorData<List<ArticleEntity>>(value: []);

  //初始化view
  Future initHttp() async {
    await request(requestType: RequestType.page, () async {
      //异步请求
      await Future.wait([
        handle(
          () => getIt<HomeService>().banner(),
          (it) => bannerEntityList.value = it,
          requestType: RequestType.page,
        ),
        //异步中同步
        Future.sync(() async {
          //置顶文章
          List<ArticleEntity> articleTop = [];
          if (requestNum == CommonConstant.initialPageNum) {
            await handle(
              () => getIt<HomeService>().articleTopJson(),
              (it) => articleTop = it.map((e) => e..isTop = true).toList(),
              requestType: RequestType.refresh,
            );
          }
          //文章列表
          await handle(
            () => getIt<HomeService>().articleList(requestNum),
            (it) => {
              handleData(articleEntityList, it.datas),
              articleEntityList.value!.insertAll(0, articleTop),
            },
            requestType: RequestType.refresh,
          );
        })
      ]);
    });
  }

  //文章
  Future getArticleList() async {
    await request(requestType: RequestType.refresh, () async {
      //置顶文章
      List<ArticleEntity> articleTop = [];
      if (requestNum == CommonConstant.initialPageNum) {
        await handle(
          () => getIt<HomeService>().articleTopJson(),
          (it) => articleTop = it.map((e) => e..isTop = true).toList(),
          requestType: RequestType.refresh,
        );
      }
      //文章列表
      await handle(
        () => getIt<HomeService>().articleList(requestNum),
        (it) => {
          handleData(articleEntityList, it.datas),
          articleEntityList.value!.insertAll(0, articleTop),
        },
        requestType: RequestType.refresh,
      );
    });
  }
}
