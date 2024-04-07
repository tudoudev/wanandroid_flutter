import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/base/page_state_provider.dart';
import 'package:wanandroid_flutter/base/refresh_widget.dart';
import 'package:wanandroid_flutter/base/selector_widget.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/home/widget/article_widget.dart';
import 'package:wanandroid_flutter/page/main/view/drawer_page.dart';
import 'package:wanandroid_flutter/page/square/viewmodel/square_view_model.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/res/strings.dart';

/*
 * Description：<广场>
 * Created by：zzl
 * Time：2024/3/8  09:10
 */
class SquarePage extends StatefulWidget {
  const SquarePage({super.key});

  @override
  State<SquarePage> createState() => _SquarePageState();
}

class _SquarePageState extends BaseState<SquareViewModel, SquarePage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  // 是否显示悬浮按钮
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    //初始化请求
    mViewModel.initView(RequestType.page);
    //listview滚动监听
    _scrollController.addListener(() {
      if (_scrollController.offset < 200 && _isShowFAB) {
        setState(() {
          _isShowFAB = false;
        });
      } else if (_scrollController.offset >= 200 && !_isShowFAB) {
        setState(() {
          _isShowFAB = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text(MStrings.commonText_2),
      ),
      body: PageStateProvider(
        viewModel: mViewModel,
        onLoadRetry: () => mViewModel.initView(RequestType.page),
        builder: (context) => Column(
          children: [
            SelectorWidget<SquareViewModel, SelectorData<List<ArticleEntity>>>(
              selector: (context, _) => mViewModel.articleEntityList,
              builder: (context, it, child) {
                return Expanded(
                  child: RefreshWidget(
                    viewModel: mViewModel,
                    onRefresh: () async => await mViewModel.initView(RequestType.refresh),
                    onLoad: () async => await mViewModel.initView(RequestType.refresh),
                    child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (context, index) {
                        return Divider(thickness: 0.3.w, height: 0);
                      },
                      itemCount: it.value!.length,
                      itemBuilder: (context, index) {
                        return ArticleWidget(item: it.value![index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: !_isShowFAB
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                // 回到顶部时要执行的动画
                _scrollController.animateTo(0, duration: const Duration(milliseconds: 2000), curve: Curves.ease);
              },
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
