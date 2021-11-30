import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:y_listener/screens/home_screen.dart';

//import 'dart:ui/Image';
void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Youtube Listener';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: HomeScreen(),
    );
  }
}
