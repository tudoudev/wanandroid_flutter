import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/router_helper.dart';
import 'package:wanandroid_flutter/util/common_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.goto(RouterConstant.mainPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(CommonUtil.getImgPath('ic_launcher_news')),
          radius: 46.w,
        ),
      ),
    );
  }
}
