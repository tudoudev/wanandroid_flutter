import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/extension/double_helper.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/register_view_model.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';

import '../../../res/m_string.dart';

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
  Widget initView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MString.commonText_23),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            20.hGap,
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(MString.commonText_24, style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              child: const Text(MString.commonText_25, style: TextStyle(fontSize: 12, color: MColors.gray_99)),
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
            TextField(
              controller: _psdAgainController,
              decoration: const InputDecoration(
                labelText: MString.commonText_26,
                hintText: MString.commonText_27,
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
                  String repassword = _psdAgainController.text;
                  var map = FormData.fromMap({
                    "username": username,
                    "password": password,
                    "repassword": repassword,
                  });
                  mViewModel.register(map);
                },
                child: const Text(MString.commonText_23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
