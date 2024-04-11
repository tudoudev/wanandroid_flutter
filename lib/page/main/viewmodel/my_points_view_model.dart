import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/main_service.dart';

import '../../../base/base_view_model.dart';

@injectable
class MyPointsViewModel extends BaseViewModel {

  Future initView(RequestType requestType) async {
    await request(requestType: requestType, () async {
      await handle(
        () => getIt<MainService>().lgCoinList(requestNum),
        (it) => {},
        requestType: requestType,
      );
    });
  }
}
