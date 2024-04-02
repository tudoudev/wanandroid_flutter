import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/extension/router_helper.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/res/strings.dart';

class ArticleWidget extends StatelessWidget {
  ArticleEntity item;

  ArticleWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goto(RouterConstant.webView, extra: {'url': item.link, 'title': item.title});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
            child: Row(
              children: [
                Visibility(
                    visible: item.isTop,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MColors.c_f44336, width: 0.5.w),
                        borderRadius: BorderRadius.all(Radius.circular(2.w)),
                      ),
                      padding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
                      margin: EdgeInsets.fromLTRB(0, 0, 4.w, 0),
                      child: Text(MStrings.homeText_1, style: TextStyle(fontSize: 10.sp, color: MColors.c_f44336)),
                    )),
                Visibility(
                    visible: item.fresh,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MColors.c_f44336, width: 0.5.w),
                        borderRadius: BorderRadius.all(Radius.circular(2.w)),
                      ),
                      padding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
                      margin: EdgeInsets.fromLTRB(0, 0, 4.w, 0),
                      child: Text(MStrings.homeText_2, style: TextStyle(fontSize: 10.sp, color: MColors.c_f44336)),
                    )),
                Visibility(
                    visible: item.tags.isNotEmpty,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MColors.c_a00bcd4, width: 0.5.w),
                        borderRadius: BorderRadius.all(Radius.circular(2.w)),
                      ),
                      padding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
                      margin: EdgeInsets.fromLTRB(0, 0, 4.w, 0),
                      child: Text(item.tags.isNotEmpty ? item.tags[0].name : "", style: TextStyle(fontSize: 10.sp, color: MColors.c_a00bcd4)),
                    )),
                Text(
                  item.author.isNotEmpty ? item.author : item.shareUser,
                  style: TextStyle(fontSize: 12.sp, color: MColors.gray_66),
                  textAlign: TextAlign.left,
                ),
                Expanded(
                  child: Text(
                    item.niceDate,
                    style: TextStyle(fontSize: 12.sp, color: MColors.gray_66),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
            child: Text(item.title, style: TextStyle(fontSize: 14.sp)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
            child: Row(
              children: [
                Text(
                  "${item.superChapterName} / ${item.chapterName}",
                  style: TextStyle(fontSize: 12.sp, color: MColors.gray_66),
                ),
                const Spacer(),
                Icon(
                  Icons.favorite_border,
                  size: 22,
                  color: MColors.gray_66,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
