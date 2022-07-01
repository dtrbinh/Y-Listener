// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:y_listener/src/core/constants/youtube_api_key.dart';

class APIProvider extends ChangeNotifier {
  int index = 1;
  void changeAPIKey() {
    if (index >= 0 && index < listKey.length - 1) {
      print('Change API from key $index to key ${index++}.');
    } else {
      index = 0;
      print('Selected default key.');
    }
    keySelected = listKey[index];
    notifyListeners();
  }
}
