import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/main_service.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/res/m_string.dart';

@injectable
class ArticleViewModel extends BaseViewModel {
  late ArticleEntity articleEntity;

  //收藏、取消收藏
  Future collectAndUncollect({RequestType requestType = RequestType.page}) async {
    if (articleEntity.collect) {
      await request(requestType: requestType, () async {
        await handle(
          () => getIt<MainService>().uncollect(articleEntity.id),
          (it) => {articleEntity.collect = false, EasyLoading.showToast(MString.commonText_33)},
          requestType: requestType,
        );
      });
    } else {
      await request(requestType: requestType, () async {
        await handle(
          () => getIt<MainService>().collect(articleEntity.id),
          (it) => {articleEntity.collect = true, EasyLoading.showToast(MString.commonText_32)},
          requestType: requestType,
        );
      });
    }
  }
}
