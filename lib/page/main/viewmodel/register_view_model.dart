import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:wanandroid_flutter/injector/injector.dart';
import 'package:wanandroid_flutter/network/api/main_service.dart';

import '../../../base/base_view_model.dart';
import '../../../res/m_string.dart';

@injectable
class RegisterViewModel extends BaseViewModel {
  late Function() registerSuccess;

  Future register(FormData map) async {
    await request(requestType: RequestType.dialog, () async {
      await handle(
        () => getIt<MainService>().register(map),
        (it) => {
          registerSuccess(),
          EasyLoading.showToast(MString.commonText_24),
        },
        requestType: RequestType.dialog,
      );
    });
  }
}
