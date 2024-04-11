import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/square_service.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';

@injectable
class SquareViewModel extends BaseViewModel {
  var articleEntityList = SelectorData<List<ArticleEntity>>(value: []);

  //文章
  Future initView(RequestType page) async {
    await request(requestType: page, () async {
      await handle(
        () => getIt<SquareService>().userArticleList(requestNum),
        (it) => handleData(articleEntityList, it.datas),
        requestType: page,
      );
    });
  }
}
