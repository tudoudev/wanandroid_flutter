import 'package:flutter/cupertino.dart';

extension DoubleHelper on num {
  //高度间隔
  Widget get hGap => SizedBox(height: toDouble());

  //宽度间隔
  Widget get wGap => SizedBox(width: toDouble());
}
