import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/extension/double_helper.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/register_view_model.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends BaseState<RegisterViewModel, RegisterPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _psdController = TextEditingController();
  final TextEditingController _psdAgainController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //注册成功
    mViewModel.registerSuccess = () {
      context.pop();
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtil.get().main_15),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            20.w.hGap,
            Container(
              alignment: Alignment.centerLeft,
              child: Text(StringUtil.get().main_16, style: TextStyle(fontSize: 16.sp)),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.w),
              alignment: Alignment.centerLeft,
              child: Text(StringUtil.get().main_17, style: TextStyle(fontSize: 12.sp, color: MColors.gray_99)),
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
            TextField(
              controller: _psdAgainController,
              decoration: InputDecoration(
                labelText: StringUtil.get().main_18,
                hintText: StringUtil.get().main_19,
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
                  String repassword = _psdAgainController.text;
                  var map = FormData.fromMap({
                    "username": username,
                    "password": password,
                    "repassword": repassword,
                  });
                  mViewModel.register(map);
                },
                child: Text(StringUtil.get().main_15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
