import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/main_service.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';

import '../../../base/base_view_model.dart';
import '../../../widget/selector_widget.dart';
import '../../home/model/integrate_entity.dart';

@injectable
class MyCollectViewModel extends BaseViewModel {
  var articleEntityList = SelectorData<List<ArticleEntity>>(value: []);

  Future initHttp(int requestNum, {RequestType requestType = RequestType.page}) async {
    await request(requestType: requestType, () async {
      await handle(
        () => getIt<MainService>().collectList(requestNum),
        (it) => handleData(articleEntityList, it.datas),
        requestType: requestType,
      );
    });
  }
}
