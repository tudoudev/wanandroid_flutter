import 'package:flutter_gen/gen_l10n/l10n1.dart';
import 'package:wanandroid_flutter/constant/common_constant.dart';

class StringUtil {
  //获取AppLocalizations
  static AppLocalizations get() {
    return AppLocalizations.of(CommonConstant.navKey.currentState!.context)!;
  }

}
