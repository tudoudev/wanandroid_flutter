import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/init_config.dart';
import 'package:wanandroid_flutter/constant/bus_code.dart';
import 'package:wanandroid_flutter/constant/cache_manager.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/double_helper.dart';
import 'package:wanandroid_flutter/extension/router_helper.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/util/common_util.dart';
import 'package:wanandroid_flutter/util/string_util.dart';

// 侧滑页面
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String username = StringUtil.get().main_1;
  String level = StringUtil.get().commonNoData; // 等级
  String rank = StringUtil.get().commonNoData; // 排名

  @override
  void initState() {
    super.initState();
    initUserInfo();
    //登录状态
    eventBus.on<LoginStateBus>().listen((event) {
      setState(() => initUserInfo());
    });
  }

  //初始化用户信息
  initUserInfo() {
    var userInfoEntity = CacheManager.instance.getUserInfo();
    if (userInfoEntity != null) {
      username = userInfoEntity.username;
      level = (userInfoEntity.coinCount ~/ 100 + 1).toString();
    } else {
      username = StringUtil.get().main_1;
      level = StringUtil.get().commonNoData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 40.w, 16.w, 10.w),
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    CommonUtil.getImgPath('ic_rank'),
                    color: Colors.white,
                    width: 20,
                    height: 20,
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(CommonUtil.getImgPath("ic_default_avatar")),
                  radius: 40.w,
                ),
                10.w.hGap,
                Text(username, style: TextStyle(fontSize: 18.w, color: MColors.white)),
                5.w.hGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(StringUtil.get().main_2, style: TextStyle(fontSize: 11.sp, color: MColors.gray_f5), textAlign: TextAlign.center),
                    Text(level, style: TextStyle(fontSize: 11.sp, color: MColors.gray_f5), textAlign: TextAlign.center),
                    5.w.wGap,
                    Text(StringUtil.get().main_3, style: TextStyle(fontSize: 11.sp, color: MColors.gray_f5), textAlign: TextAlign.center),
                    Text(rank, style: TextStyle(fontSize: 11.sp, color: MColors.gray_f5), textAlign: TextAlign.center),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            onTap: () => context.goto(RouterConstant.myPointsPage),
            title: Text(
              StringUtil.get().main_4,
              style: TextStyle(fontSize: 14.sp),
            ),
            leading: Image.asset(
              CommonUtil.getImgPath('ic_score'),
              width: 22.w,
              height: 22.w,
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text(
              StringUtil.get().main_5,
              style: TextStyle(fontSize: 14.sp),
            ),
            leading: Icon(Icons.favorite_border, size: 22.w, color: Theme.of(context).primaryColor),
          ),
          ListTile(
            title: Text(
              StringUtil.get().main_6,
              style: TextStyle(fontSize: 14.sp),
            ),
            leading: Image.asset(
              CommonUtil.getImgPath('ic_share'),
              width: 22.w,
              height: 22.w,
              color: Theme.of(context).primaryColor,
            ),
          ),
          InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(StringUtil.get().main_23),
                actions: [
                  TextButton(
                      onPressed: () => {
                            CacheManager.instance.clearUserInfo(),
                            eventBus.fire(LoginStateBus()),
                            context.pop(),
                          },
                      child: Text(StringUtil.get().commonOk)),
                  TextButton(onPressed: () => context.pop(), child: Text(StringUtil.get().commonCancel)),
                ],
              ),
            ),
            child: Visibility(
              visible: CacheManager.instance.getUserInfo() != null,
              child: ListTile(
                title: Text(
                  StringUtil.get().main_22,
                  style: TextStyle(fontSize: 14.sp),
                ),
                leading: Icon(Icons.power_settings_new, size: 22.w, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
