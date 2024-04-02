import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/base/selector_widget.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/wx_chat_service.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';

@injectable
class WxChatViewModel extends BaseViewModel {
  var chaptersEntityList = SelectorData<List<ChaptersEntity>>(value: []);
  var wxArticleEntityList = SelectorData<List<ArticleEntity>>(value: []);

  //初始化view
  Future initView() async {
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
}
