import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/init_config.dart';
import 'package:wanandroid_flutter/constant/bus_code.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/double_helper.dart';
import 'package:wanandroid_flutter/extension/router_helper.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/login_view_model.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BaseState<LoginViewModel, LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _psdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //登录状态
    eventBus.on<LoginStateBus>().listen((event) {
      context.pop();
      EasyLoading.showToast(StringUtil.get().main_21);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtil.get().main_7),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            20.w.hGap,
            Container(
              alignment: Alignment.centerLeft,
              child: Text(StringUtil.get().main_8, style: TextStyle(fontSize: 16.sp)),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.w),
              alignment: Alignment.centerLeft,
              child: Text(StringUtil.get().main_9, style: TextStyle(fontSize: 12.sp, color: MColors.gray_99)),
            ),
            TextField(
              autofocus: false,
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: StringUtil.get().main_10,
                hintText: StringUtil.get().main_11,
                labelStyle: const TextStyle(color: Colors.cyan),
              ),
              maxLines: 1,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            TextField(
              controller: _psdController,
              decoration: InputDecoration(
                labelText: StringUtil.get().main_12,
                hintText: StringUtil.get().main_13,
                labelStyle: const TextStyle(color: Colors.cyan),
              ),
              obscureText: true,
              maxLines: 1,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            30.w.hGap,
            SizedBox(
              height: 50.w,
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
                child: Text(StringUtil.get().main_7),
              ),
            ),
            10.w.hGap,
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.goto(RouterConstant.registerPage),
                child: Text(
                  StringUtil.get().main_14,
                  style: const TextStyle(color: MColors.appMain),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
