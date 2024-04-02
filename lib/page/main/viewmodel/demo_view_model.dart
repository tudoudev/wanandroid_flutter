import 'package:injectable/injectable.dart';

import '../../../base/base_view_model.dart';

@injectable
class DemoViewModel extends BaseViewModel {
  var aaa = 0;

  void change() {
    aaa++;
    notifyListeners();
  }
}
