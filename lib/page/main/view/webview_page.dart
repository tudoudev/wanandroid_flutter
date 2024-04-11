import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wanandroid_flutter/base/base_state.dart';
import 'package:wanandroid_flutter/base/base_view_model.dart';
import 'package:wanandroid_flutter/widget/page_state_provider.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/webview_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends BaseState<WebViewViewModel, WebViewPage> {
  late String title;
  late String url;

  bool isLoad = true;
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    final extraData = GoRouterState.of(context).extra! as Map<String, String>; // 获取额外数据
    title = extraData["title"].toString();
    url = extraData["url"].toString();
    //控制器
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            mViewModel.changePageState(PageState.loading);
          },
          onPageFinished: (String url) {
            mViewModel.changePageState(PageState.success);
          },
          onWebResourceError: (WebResourceError error) async {
            final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult.contains(ConnectivityResult.none)) {
              mViewModel.changePageState(PageState.noNetwork);
            } else {
              mViewModel.changePageState(PageState.failed);
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    //view
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: PageStateProvider(
        viewModel: mViewModel,
        onLoadRetry: () {
          mViewModel.changePageState(PageState.loading);
          controller.loadRequest(Uri.parse(url));
        },
        builder: (context) => WebViewWidget(controller: controller),
      ),
    );
  }
}
