import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/system_service.dart';
import 'package:wanandroid_flutter/page/system/model/navigation_entity.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';

@injectable
class SystemViewModel extends BaseViewModel {
  var chaptersEntityList = SelectorData<List<ChaptersEntity>>(value: []);
  var navigationEntityList = SelectorData<List<NavigationEntity>>(value: []);

  //体系数据
  Future treeJson(RequestType requestType) async {
    await request(requestType: requestType, () async {
      await handle(
        () => getIt<SystemService>().treeJson(),
        (it) => handleData(chaptersEntityList, it),
        requestType: requestType,
      );
    });
  }

  //导航数据
  Future naviJson(RequestType requestType) async {
    await request(requestType: requestType, () async {
      await handle(
            () => getIt<SystemService>().naviJson(),
            (it) => handleData(navigationEntityList, it),
        requestType: requestType,
      );
    });
  }
}
