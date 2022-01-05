import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_listener/screens/home_screen.dart';
import 'package:youtube_api/youtube_api.dart';

void main() {
  runApp(const MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Youtube Listener';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => VideoInfor(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: HomeScreen(),
      ),
      //home: HomeScreen(),
    );
  }
}

class VideoInfor with ChangeNotifier {
  List<YouTubeVideo> searchResult = List.empty(growable: true);
  List<YouTubeVideo> trendResult = List.empty(growable: true);
  List<YouTubeVideo> historyVideo = List.empty(growable: true);
  List<String> historySearch = List.empty(growable: true);
  late int apiKey = 1;
  late String regionCode = 'EN';
}
