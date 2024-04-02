// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../network/api/home_service.dart' as _i4;
import '../network/api/project_service.dart' as _i7;
import '../network/api/square_service.dart' as _i9;
import '../network/api/system_service.dart' as _i11;
import '../network/api/wx_chat_service.dart' as _i14;
import '../network/ApiModule.dart' as _i16;
import '../page/home/viewmodel/home_view_model.dart' as _i5;
import '../page/main/viewmodel/demo_view_model.dart' as _i3;
import '../page/main/viewmodel/main_view_model.dart' as _i6;
import '../page/main/viewmodel/webview_view_model.dart' as _i13;
import '../page/project/viewmodel/project_view_model.dart' as _i8;
import '../page/square/viewmodel/square_view_model.dart' as _i10;
import '../page/system/viewmodel/system_view_model.dart' as _i12;
import '../page/wxchat/viewmodel/wxchat_view_model.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final apiModule = _$ApiModule();
    gh.factory<_i3.DemoViewModel>(() => _i3.DemoViewModel());
    gh.factory<_i4.HomeService>(() => apiModule.provideHomeService());
    gh.factory<_i5.HomeViewModel>(() => _i5.HomeViewModel());
    gh.factory<_i6.MainViewModel>(() => _i6.MainViewModel());
    gh.factory<_i7.ProjectService>(() => apiModule.provideProjectService());
    gh.factory<_i8.ProjectViewModel>(() => _i8.ProjectViewModel());
    gh.factory<_i9.SquareService>(() => apiModule.provideSquareService());
    gh.factory<_i10.SquareViewModel>(() => _i10.SquareViewModel());
    gh.factory<_i11.SystemService>(() => apiModule.provideSystemService());
    gh.factory<_i12.SystemViewModel>(() => _i12.SystemViewModel());
    gh.factory<_i13.WebViewViewModel>(() => _i13.WebViewViewModel());
    gh.factory<_i14.WxChatService>(
        () => apiModule.provideOfficialAccountService());
    gh.factory<_i15.WxChatViewModel>(() => _i15.WxChatViewModel());
    return this;
  }
}

class _$ApiModule extends _i16.ApiModule {}
