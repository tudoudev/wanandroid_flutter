// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../network/api/home_service.dart' as _i14;
import '../network/api/main_service.dart' as _i13;
import '../network/api/project_service.dart' as _i18;
import '../network/api/square_service.dart' as _i15;
import '../network/api/system_service.dart' as _i17;
import '../network/api/wx_chat_service.dart' as _i16;
import '../network/ApiModule.dart' as _i19;
import '../page/home/viewmodel/home_view_model.dart' as _i3;
import '../page/main/viewmodel/login_view_model.dart' as _i9;
import '../page/main/viewmodel/main_view_model.dart' as _i10;
import '../page/main/viewmodel/my_points_view_model.dart' as _i8;
import '../page/main/viewmodel/register_view_model.dart' as _i11;
import '../page/main/viewmodel/webview_view_model.dart' as _i12;
import '../page/project/viewmodel/project_view_model.dart' as _i6;
import '../page/square/viewmodel/square_view_model.dart' as _i4;
import '../page/system/viewmodel/system_view_model.dart' as _i7;
import '../page/wxchat/viewmodel/wxchat_view_model.dart' as _i5;

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
    gh.factory<_i3.HomeViewModel>(() => _i3.HomeViewModel());
    gh.factory<_i4.SquareViewModel>(() => _i4.SquareViewModel());
    gh.factory<_i5.WxChatViewModel>(() => _i5.WxChatViewModel());
    gh.factory<_i6.ProjectViewModel>(() => _i6.ProjectViewModel());
    gh.factory<_i7.SystemViewModel>(() => _i7.SystemViewModel());
    gh.factory<_i8.MyPointsViewModel>(() => _i8.MyPointsViewModel());
    gh.factory<_i9.LoginViewModel>(() => _i9.LoginViewModel());
    gh.factory<_i10.MainViewModel>(() => _i10.MainViewModel());
    gh.factory<_i11.RegisterViewModel>(() => _i11.RegisterViewModel());
    gh.factory<_i12.WebViewViewModel>(() => _i12.WebViewViewModel());
    gh.factory<_i13.MainService>(() => apiModule.provideMainService());
    gh.factory<_i14.HomeService>(() => apiModule.provideHomeService());
    gh.factory<_i15.SquareService>(() => apiModule.provideSquareService());
    gh.factory<_i16.WxChatService>(
        () => apiModule.provideOfficialAccountService());
    gh.factory<_i17.SystemService>(() => apiModule.provideSystemService());
    gh.factory<_i18.ProjectService>(() => apiModule.provideProjectService());
    return this;
  }
}

class _$ApiModule extends _i19.ApiModule {}
