import 'package:flutter/cupertino.dart';


class _Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    } else {}
  }
}
