import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:y_listener/screens/home_screen.dart';
import 'package:y_listener/models/background process/audio_bg_process.dart';

// void main() {
//   runApp(const MyApp());
// }
//

late AudioHandler _audioHandler;

Future<void> main() async {
  _audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
  runApp(const MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Youtube Listener';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: HomeScreen(),
      //home: HomeScreen(),
    );
  }
}
