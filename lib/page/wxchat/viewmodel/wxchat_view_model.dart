import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/res/m_string.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/wx_chat_service.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';

import '../../../network/api/main_service.dart';

@injectable
class WxChatViewModel extends BaseViewModel {
  var chaptersEntityList = SelectorData<List<ChaptersEntity>>(value: []);
  var wxArticleEntityList = SelectorData<List<ArticleEntity>>(value: []);
  late ArticleEntity articleEntity;

  //初始化view
  Future initHttp() async {
    await request(requestType: RequestType.page, () async {
      await handle(
        () => getIt<WxChatService>().wxArticleChapters(),
        (it) => {chaptersEntityList.value = it},
        requestType: RequestType.page,
      );
    });
  }

  //微信公众号文章
  Future wxArticleList(RequestType requestType, int id) async {
    await request(requestType: requestType, () async {
      await handle(
        () => getIt<WxChatService>().wxArticleList(id, requestNum),
        (it) => handleData(wxArticleEntityList, it.datas),
        requestType: requestType,
      );
    });
  }


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
