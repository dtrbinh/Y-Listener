// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:y_listener/src/core/constants/youtube_api_key.dart';

class APIProvider extends ChangeNotifier {
  int index = 1;
  void changeAPIKey() {
    index = Random().nextInt(listKey.length);
    print('Change API to key $index.');
    keySelected = listKey[index];
    notifyListeners();
  }
}
