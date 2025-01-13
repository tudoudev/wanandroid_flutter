import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/resource_config.dart';
import 'package:wanandroid_flutter/res/m_string.dart';

class ListViewWidget<A, S> extends StatefulWidget {
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final int itemCount;
  final IndexedWidgetBuilder? separatorBuilder;
  final NullableIndexedWidgetBuilder itemBuilder;
  final ScrollPhysics? physics;

  const ListViewWidget({
    super.key,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.separatorBuilder,
    this.physics,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<ListViewWidget<A, S>> createState() => _ListViewWidgetState<A, S>();
}

class _ListViewWidgetState<A, S> extends State<ListViewWidget<A, S>> {
  @override
  Widget build(BuildContext context) {
    return widget.itemCount == 0
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double visibleHeight = constraints.maxHeight;
              return SingleChildScrollView(
                child: SizedBox(
                  height: widget.shrinkWrap ? null : visibleHeight,
                  child: Column(
                    children: [
                      Image.asset(getImgPath("common_empty"), height: 100),
                      const Text(MString.commonEmptyData),
                    ],
                  ),
                ),
              );
            },
          )
        : ListView.separated(
            controller: widget.controller,
            padding: widget.padding,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            separatorBuilder: widget.separatorBuilder ?? (context, index) => Container(),
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder);
  }
}
