import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/init_config.dart';
import 'package:wanandroid_flutter/constant/bus_code.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/double_helper.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/login_view_model.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';

import '../../../base/app_router.dart';
import '../../../res/m_string.dart';

class LoginPage extends StatefulHookWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BaseState<LoginViewModel, LoginPage> {
  late TextEditingController _userNameController;

  late TextEditingController _psdController;

  @override
  void initState() {
    super.initState();
    //登录状态
    eventBus.on<LoginStateBus>().listen((event) {
      context.pop();
      EasyLoading.showToast(MString.commonText_29);
    });
  }

  @override
  Widget initView(BuildContext context) {
    _userNameController = useTextEditingController();
    _psdController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(MString.commonText_15),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            20.hGap,
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(MString.commonText_16, style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              child: const Text(MString.commonText_17, style: TextStyle(fontSize: 12, color: MColors.gray_99)),
            ),
            TextField(
              autofocus: false,
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: MString.commonText_18,
                hintText: MString.commonText_19,
                labelStyle: TextStyle(color: Colors.cyan),
              ),
              maxLines: 1,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            TextField(
              controller: _psdController,
              decoration: const InputDecoration(
                labelText: MString.commonText_20,
                hintText: MString.commonText_21,
                labelStyle: TextStyle(color: Colors.cyan),
              ),
              obscureText: true,
              maxLines: 1,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            30.hGap,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String username = _userNameController.text;
                  String password = _psdController.text;
                  var map = FormData.fromMap({
                    "username": username,
                    "password": password,
                  });
                  mViewModel.login(map);
                },
                child: const Text(MString.commonText_15),
              ),
            ),
            10.hGap,
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => goto(RouterConstant.RegisterPage),
                child: const Text(
                  MString.commonText_22,
                  style: TextStyle(color: MColors.appMain),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
