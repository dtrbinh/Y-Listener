// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:y_listener/models/api/channel_icon.dart';
import 'package:y_listener/screens/settings/API.dart';
import 'package:y_listener/utils/youtube_api.dart';
import 'package:youtube_api/youtube_api.dart';

class AppVariable with ChangeNotifier {
  int index = 1;
  YoutubeAPI youtube = YoutubeAPI(apiKey);
  String queryString = "";
  List<YouTubeVideo> trendResult = List.empty(growable: true);
  List<YouTubeVideo> searchResult = List.empty(growable: true);
  List<YouTubeVideo> historyVideo = List.empty(growable: true);
  List<String> historySearch = List.empty(growable: true);
  List<String> videoPlaylist = List.empty(growable: true);
  List<String> trendIconList = List.empty(growable: true);
  List<String> searchIconList = List.empty(growable: true);
  List<String> videoInfo = List.empty(growable: true);

  String region = 'VN';
  List<String> regionCode = [];

  void changeAPI() {
    if (index >= 0 && index < key.length - 1) {
      var temp = index + 1;
      print('Change API from key $index to key $temp');
      index++;
    } else {
      index = 1;
      print('Back to key 1');
    }
    apiKey = key[index];
    notifyListeners();
  }

  Future<void> callDefaultAPI() async {
    print('Calling trending...');
    try {
      trendResult = await youtube.getTrends(regionCode: region);
    } catch (e) {
      print('Exception handled!');
      print(e);
      changeAPI();
      youtube = YoutubeAPI(apiKey);
      callDefaultAPI();
    }
    generateIconList(trendIconList);
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
        regionCode: region,
      );
    } catch (e) {
      print('Exception handled!');
      print(e);
      changeAPI();
      youtube = YoutubeAPI(apiKey);
      callAPI(query);
    }
    generateIconList(searchIconList);
    print("Searched!");
    notifyListeners();
  }

  Future<void> extendSearchResult(scrollController) async {
    if (scrollController.position.extentAfter < 200) {
      searchResult = searchResult + await youtube.nextPage();
      print('Loaded next page!');
      notifyListeners();
    }
  }

  void extendHistoryVideo(video) {
    int cplx = 0;
    for (int i = 0; i < historyVideo.length; i++) {
      if (video.id == historyVideo[i].id) cplx++;
    }
    if (cplx == 0) {
      historyVideo.add(video);
    } else {}
    notifyListeners();
  }

  void deleteVideoHistory() {
    historyVideo.clear();
    notifyListeners();
  }

  void generatePlaylist() {
    YouTubeVideo vid;
    for (int i = 0; i < searchResult.length; i++) {
      vid = searchResult[i];
      videoPlaylist.add(vid.id ?? "");
    }
    notifyListeners();
  }

  Future<void> generateIconList(List<String> out) async {
    for (var i = 0; i < searchResult.length; i++) {
      out[i] =
          getChannelIcon(searchResult[i].channelId ?? '', apiKey) as String;
    }
    notifyListeners();
  }
}
