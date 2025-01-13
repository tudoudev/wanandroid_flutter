import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/project_service.dart';
import 'package:wanandroid_flutter/page/wxchat/model/chapters_entity.dart';

@injectable
class ProjectViewModel extends BaseViewModel {
  var chaptersEntityList = SelectorData<List<ChaptersEntity>>(value: []);

  //项目分类
  Future initHttp() async {
    await request(requestType: RequestType.page, () async {
      await handle(
        () => getIt<ProjectService>().projectTreeJson(),
        (it) => handleData(chaptersEntityList, it),
        requestType: RequestType.page,
      );
    });
  }

}
