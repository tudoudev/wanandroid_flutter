import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/base/init_config.dart';
import 'package:wanandroid_flutter/constant/bus_code.dart';
import 'package:wanandroid_flutter/constant/cache_manager.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/main_service.dart';

import '../../../base/base_view_model.dart';

@injectable
class LoginViewModel extends BaseViewModel {
  Future login(FormData map) async {
    await request(requestType: RequestType.dialog, () async {
      await handle(
        () => getIt<MainService>().login(map),
        (it) => {
          it.isLogin = true,
          CacheManager.instance.setUserInfo(it),
          eventBus.fire(LoginStateBus()),
        },
        requestType: RequestType.dialog,
      );
    });
  }
}
