import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_state_keep_alive.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';
import 'package:wanandroid_flutter/page/home/model/banner_entity.dart';
import 'package:wanandroid_flutter/page/home/viewmodel/home_view_model.dart';
import 'package:wanandroid_flutter/page/common/widget/article_widget.dart';
import 'package:wanandroid_flutter/widget/listview_widget.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/widget/refresh_widget.dart';
import 'package:wanandroid_flutter/widget/selector_widget.dart';

/*
 * Description：<首页>
 * Created by：zzl
 * Time：2024/3/8  09:10
 */
class HomePage extends StatefulHookWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseStateKeepAlive<HomeViewModel, HomePage> {
  late ScrollController _scrollController;

  // 是否显示悬浮按钮
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    //初始化请求
    mViewModel.initHttp();
  }

  @override
  Widget initView(BuildContext context) {
    _scrollController = useScrollController();
    //listview滚动监听
    useEffect(() {
      temp() {
        if (_scrollController.offset < 200 && _isShowFAB) {
          setState(() {
            _isShowFAB = false;
          });
        } else if (_scrollController.offset >= 200 && !_isShowFAB) {
          setState(() {
            _isShowFAB = true;
          });
        }
      }

      _scrollController.addListener(temp);
      return () => _scrollController.removeListener(temp);
    }, []);
    return Scaffold(
      body: PageStateProvider(
        viewModel: mViewModel,
        onLoadRetry: () => mViewModel.initHttp(),
        builder: (context) => Column(
          children: [
            SelectorWidget<HomeViewModel, SelectorData<List<BannerEntity>>>(
              selector: (context, _) => mViewModel.bannerEntityList,
              builder: (context, it, child) {
                return SizedBox(
                  height: 200,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(it.value![index].imagePath, fit: BoxFit.fill);
                    },
                    itemCount: it.value!.length,
                    pagination: const SwiperPagination(),
                  ),
                );
              },
            ),
            SelectorWidget<HomeViewModel, SelectorData<List<ArticleEntity>>>(
              selector: (context, _) => mViewModel.articleEntityList,
              builder: (context, it, child) {
                return Expanded(
                  child: RefreshWidget(
                    viewModel: mViewModel,
                    onRefresh: () async => await mViewModel.getArticleList(),
                    onLoad: () async => await mViewModel.getArticleList(),
                    child: ListViewWidget(
                      separatorBuilder: (context, index) {
                        return const Divider(thickness: 0.3, height: 0);
                      },
                      itemCount: it.value!.length,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return ArticleWidget(articleEntity: it.value![index]);
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
}
