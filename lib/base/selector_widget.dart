import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorWidget<A, S> extends StatefulWidget {
  final Widget Function(BuildContext context, S value, Widget? child) builder;
  final Widget? child;
  final S Function(BuildContext, A) selector;

  const SelectorWidget({
    super.key,
    required this.builder,
    this.child,
    required this.selector,
  });

  @override
  State<SelectorWidget<A, S>> createState() => _SelectorWidgetState<A, S>();
}

class _SelectorWidgetState<A, S> extends State<SelectorWidget<A, S>> {
  @override
  Widget build(BuildContext context) {
    return Selector<A, S>(
      builder: widget.builder,
      selector: widget.selector,
      shouldRebuild: (pre, next) {
        if (next is SelectorData) {
          return next.shouldRebuild();
        } else {
          return pre != next;
        }
      },
      child: widget.child,
    );
  }
}

/// select 刷新 对比的是两个对象的内存地址,用这个类来解决这个问题
class SelectorData<T> {
  T? _value;
  int _version = 0;
  int _lastVersion = -1;

  T? get value => _value;

  SelectorData({Key? key, T? value}) {
    _value = value;
  }

  set value(T? value) {
    _version++;
    _value = value;
  }

  bool shouldRebuild() {
    bool isUpdate = _version != _lastVersion;
    if (isUpdate) {
      _lastVersion = _version;
    }
    return isUpdate;
  }

  call() {
    _version++;
  }
}
