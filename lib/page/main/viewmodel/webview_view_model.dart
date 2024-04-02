import 'package:injectable/injectable.dart';

import '../../../base/base_view_model.dart';

@injectable
class WebViewViewModel extends BaseViewModel {

  void changePageState(PageState pageState) {
    this.pageState = pageState;
    notifyListeners();
  }
}