import 'package:flutter/cupertino.dart';

class CommonUtil {
  //拼接图片路径
  static String getImgPath(String name, {String format = 'png'}) {
    return 'lib/res/images/$name.$format';
  }

}
