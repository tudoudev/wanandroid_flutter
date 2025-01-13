import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/app_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/constant/cache_manager.dart';
import 'package:wanandroid_flutter/constant/router_constant.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/home/viewmodel/article_view_model.dart';
import 'package:wanandroid_flutter/res/m_colors.dart';
import 'package:wanandroid_flutter/widget/custom_network_image.dart';

import '../../../res/m_string.dart';

class ArticleWidget extends StatefulWidget {
  ArticleEntity articleEntity;
  bool isShowCollect; //是否显示收藏

  ArticleWidget({super.key, required this.articleEntity, this.isShowCollect = true});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends BaseState<ArticleViewModel, ArticleWidget> {
  @override
  Widget initView(BuildContext context) {
    var articleEntity = mViewModel.articleEntity = widget.articleEntity;
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          goto(RouterConstant.WebViewPage, extra: {'url': articleEntity.link, 'title': articleEntity.title});
        },
        child: Row(children: [
          Visibility(
            visible: articleEntity.envelopePic.isNotEmpty,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              height: 130,
              width: 80,
              child: CustomNetworkImage(imageUrl: articleEntity.envelopePic),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Row(
                    children: [
                      Visibility(
                          visible: articleEntity.isTop,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MColors.c_f44336, width: 0.5),
                              borderRadius: const BorderRadius.all(Radius.circular(2)),
                            ),
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: const Text(MString.commonText_7, style: TextStyle(fontSize: 10, color: MColors.c_f44336)),
                          )),
                      Visibility(
                          visible: articleEntity.fresh,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MColors.c_f44336, width: 0.5),
                              borderRadius: const BorderRadius.all(Radius.circular(2)),
                            ),
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: const Text(MString.commonText_8, style: TextStyle(fontSize: 10, color: MColors.c_f44336)),
                          )),
                      Visibility(
                          visible: articleEntity.tags.isNotEmpty,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MColors.c_a00bcd4, width: 0.5),
                              borderRadius: const BorderRadius.all(Radius.circular(2)),
                            ),
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: Text(widget.articleEntity.tags.isNotEmpty ? articleEntity.tags[0].name : "", style: const TextStyle(fontSize: 10, color: MColors.c_a00bcd4)),
                          )),
                      Text(
                        articleEntity.author.isNotEmpty ? articleEntity.author : articleEntity.shareUser,
                        style: const TextStyle(fontSize: 12, color: MColors.gray_66),
                        textAlign: TextAlign.left,
                      ),
                      Expanded(
                        child: Text(
                          articleEntity.niceDate,
                          style: const TextStyle(fontSize: 12, color: MColors.gray_66),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text(articleEntity.title, style: const TextStyle(fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Row(
                    children: [
                      Text(
                        "${articleEntity.superChapterName} / ${articleEntity.chapterName}",
                        style: const TextStyle(fontSize: 12, color: MColors.gray_66),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: widget.isShowCollect,
                        child: InkWell(
                          onTap: () {
                            if (!CacheManager.instance.getUserInfo().isLogin) {
                              goto(RouterConstant.LoginPage);
                            } else {
                              mViewModel.collectAndUncollect(requestType: RequestType.dialog);
                            }
                          },
                          child: Icon(
                            context.watch<ArticleViewModel>().articleEntity.collect ? Icons.favorite : Icons.favorite_border,
                            size: 22,
                            color: MColors.gray_66,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      );
    });
  }
}
