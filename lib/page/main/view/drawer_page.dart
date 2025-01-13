import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/app_router.dart';
import 'package:wanandroid_flutter/base/init_config.dart';
import 'package:wanandroid_flutter/base/resource_config.dart';
import 'package:wanandroid_flutter/constant/bus_code.dart';
import 'package:wanandroid_flutter/constant/cache_manager.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/double_helper.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';
import 'package:wanandroid_flutter/util/common_util.dart';

import '../../../res/m_string.dart';

// 侧滑页面
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String username = MString.commonText_9;
  String level = MString.commonNoData; // 等级
  int coinCount = 0;

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
    if (userInfoEntity.isLogin) {
      username = userInfoEntity.username;
      level = (userInfoEntity.coinCount ~/ 100 + 1).toString();
    } else {
      username = MString.commonText_9;
      level = MString.commonNoData;
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
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 10),
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                30.hGap,
                InkWell(
                  onTap: () {
                    if (!CacheManager.instance.getUserInfo().isLogin) {
                      goto(RouterConstant.LoginPage);
                    }
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(getImgPath("ic_default_avatar")),
                        radius: 40,
                      ),
                      10.hGap,
                      Text(username, style: const TextStyle(fontSize: 18, color: MColors.white)),
                    ],
                  ),
                ),
                5.hGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(MString.commonText_10, style: TextStyle(fontSize: 11, color: MColors.gray_f5), textAlign: TextAlign.center),
                    Text(level, style: const TextStyle(fontSize: 11, color: MColors.gray_f5), textAlign: TextAlign.center),
                    // 5.wGap,
                    // const Text(MString.commonText_11, style: TextStyle(fontSize: 11, color: MColors.gray_f5), textAlign: TextAlign.center),
                    // Text(rank, style: const TextStyle(fontSize: 11, color: MColors.gray_f5), textAlign: TextAlign.center),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              CacheManager.instance.getUserInfo().isLogin ? goto(RouterConstant.MyPointsPage) : goto(RouterConstant.LoginPage);
            },
            title: const Text(
              MString.commonText_12,
              style: TextStyle(fontSize: 14),
            ),
            leading: Image.asset(
              getImgPath('ic_score'),
              width: 22,
              height: 22,
              color: Theme.of(context).primaryColor,
            ),
            trailing: Text(
              CacheManager.instance.getUserInfo().coinCount == 0 ? "" : CacheManager.instance.getUserInfo().coinCount.toString(),
              style: const TextStyle(fontSize: 12,color: MColors.gray_66 ),
            ),
          ),
          ListTile(
            onTap: () {
              CacheManager.instance.getUserInfo().isLogin ? goto(RouterConstant.MyCollectPage) : goto(RouterConstant.LoginPage);
            },
            title: const Text(
              MString.commonText_13,
              style: TextStyle(fontSize: 14),
            ),
            leading: Icon(Icons.favorite_border, size: 22, color: Theme.of(context).primaryColor),
          ),
          InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: const Text(MString.commonText_31),
                actions: [
                  TextButton(
                      onPressed: () => {
                            CacheManager.instance.removeUserInfo(),
                            eventBus.fire(LoginStateBus()),
                            context.pop(),
                          },
                      child: const Text(MString.tdConfirm)),
                  TextButton(onPressed: () => context.pop(), child: const Text(MString.tdCancel)),
                ],
              ),
            ),
            child: Visibility(
              visible: CacheManager.instance.getUserInfo().isLogin,
              child: ListTile(
                title: const Text(
                  MString.commonText_30,
                  style: TextStyle(fontSize: 14),
                ),
                leading: Icon(Icons.power_settings_new, size: 22, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
