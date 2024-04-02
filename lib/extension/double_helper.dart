import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

extension DoubleHelper on double {
  //高度间隔
  Widget get hGap => SizedBox(height: this);

  //宽度间隔
  Widget get wGap => SizedBox(width: this);
}
