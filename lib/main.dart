// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_listener/src/data/models/provider/seacher_provider.dart';
import 'package:y_listener/src/di/injector.dart';
import 'package:y_listener/src/modules/home_screen/home_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Y Listener';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearcherProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: HomeScreen(),
      ),
    );
  }
}
