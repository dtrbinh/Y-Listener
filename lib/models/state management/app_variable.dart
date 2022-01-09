// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:y_listener/screens/settings/API.dart';
import 'package:youtube_api/youtube_api.dart';

class AppVariable with ChangeNotifier {
  YoutubeAPI youtube = YoutubeAPI(apiKey);
  List<YouTubeVideo> trendResult = List.empty(growable: true);
  List<YouTubeVideo> searchResult = List.empty(growable: true);
  List<YouTubeVideo> historyVideo = List.empty(growable: true);
  List<String> historySearch = List.empty(growable: true);
  late String region = 'VN';

  Future<void> callDefaultAPI() async {
    print('Calling trending...');
    try {
      trendResult = await youtube.getTrends(regionCode: 'VN');
    } catch (e) {
      print('Exception handled!');
      print(e);
      changeAPI();
      youtube = YoutubeAPI(apiKey);
      callDefaultAPI();
    }
    print('Called Trending!');
    notifyListeners();
  }

  Future<void> callAPI(String query) async {
    if (query != '') {
    } else {
      query = 'Chill Songs';
    }
    print('Searching: ' + query);
    try {
      searchResult = await youtube.search(
        query,
        type: 'video, playlist',
        //date, rating, relevance, title, videoCount, viewCount
        order: 'relevance',
        videoDuration: 'any',
        regionCode: 'VN',
      );
    } catch (e) {
      print('Exception handled!');
      print(e);
      changeAPI();
      youtube = YoutubeAPI(apiKey);
      callAPI(query);
    }
    print("Searched!");
    notifyListeners();
  }
}
