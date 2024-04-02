import 'package:injectable/injectable.dart';

import '../../../base/base_view_model.dart';

@injectable
class MainViewModel extends BaseViewModel {
  var selectIndex = 0;

  void changeSelectIndex(int index) {
    selectIndex = index;
    notifyListeners();
  }
}
