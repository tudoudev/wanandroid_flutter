import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/extension/double_helper.dart';
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
                Text(StringUtil.get().main_1, style: TextStyle(fontSize: 18.w, color: MColors.white)),
                5.w.hGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(StringUtil.get().main_2, style: TextStyle(fontSize: 11.sp, color: MColors.gray_f5), textAlign: TextAlign.center),
                    Text(StringUtil.get().commonNoData, style: TextStyle(fontSize: 11.sp, color: MColors.gray_f5), textAlign: TextAlign.center),
                    5.w.wGap,
                    Text(StringUtil.get().main_3, style: TextStyle(fontSize: 11.sp, color: MColors.gray_f5), textAlign: TextAlign.center),
                    Text(StringUtil.get().commonNoData, style: TextStyle(fontSize: 11.sp, color: MColors.gray_f5), textAlign: TextAlign.center),
                  ],
                )
              ],
            ),
          ),
          ListTile(
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
        ],
      ),
    );
  }
}
