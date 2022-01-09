// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_listener/screens/home_screen.dart';
import 'models/state management/app_variable.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Y Listener';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppVariable(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: HomeScreen(),
      ),
    );
  }
}


