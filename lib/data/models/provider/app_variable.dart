// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:y_listener/core/constants/youtube_api.dart';
import 'package:y_listener/data/models/object/youTubeVideoInfo.dart';
import 'package:y_listener/data/models/api/channel_icon.dart';
import 'package:y_listener/data/models/api/video_info.dart';
import 'package:y_listener/screens/settings/API.dart';
import 'package:youtube_api/youtube_api.dart';

class AppVariable with ChangeNotifier {
  int index = 1;
  YoutubeAPI youtube = YoutubeAPI(apiKey);
  String queryString = "";

  List<YoutubeVideoInfo> trend = List.empty(growable: true);
  List<YoutubeVideoInfo> search = List.empty(growable: true);

  List<YouTubeVideo> trendResult = List.empty(growable: true);
  List<YouTubeVideo> searchResult = List.empty(growable: true);
  List<YouTubeVideo> historyVideo = List.empty(growable: true);

  List<String> historySearch = List.empty(growable: true);
  List<String> videoPlaylist = List.empty(growable: true);

  String region = 'VN';
  List<String> regionCode = [];

  bool trendSuccess = false;
  bool searchSuccess = false;

  bool trendIsLoad() {
    return trendSuccess;
  }
  bool searchIsLoad() {
    return searchSuccess;
  }

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
  }

  Future<void> callDefaultAPI() async {
    print('Calling trending...');
    try {
      trendResult = await youtube.getTrends(regionCode: region);
      trendSuccess = true;
      await generateTrendInfo();
      print('Called Trending!');
      notifyListeners();
    } catch (e) {
      trendSuccess = false;
      print('Exception handled!');
      print(e);
      changeAPI();
      youtube = YoutubeAPI(apiKey);
      callDefaultAPI();
    }
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
      await generateSearchInfo();
      searchSuccess = true;
      print("Searched!");
      notifyListeners();
    } catch (e) {
      searchSuccess = false;
      print('Exception handled!');
      print(e);
      changeAPI();
      youtube = YoutubeAPI(apiKey);
      callAPI(query);
    }
  }

  Future<void> generateTrendInfo() async {
    for (var i = 0; i < trendResult.length; i++) {
      var tempIcon = await getChannelIcon(trendResult[i].channelId!, apiKey);
      var tempViewCount = await getViewCount(trendResult[i].id!, apiKey);
      trend.add(YoutubeVideoInfo(trendResult[i], tempIcon, tempViewCount));
    }
    notifyListeners();
  }

  Future<void> generateSearchInfo() async {
    for (var i = 0; i < searchResult.length; i++) {
      var tempIcon = await getChannelIcon(searchResult[i].channelId!, apiKey);
      var tempViewCount = await getViewCount(searchResult[i].id!, apiKey);
      search.add(YoutubeVideoInfo(searchResult[i], tempIcon, tempViewCount));
    }
    notifyListeners();
  }

  Future<void> extendSearchResult(scrollController) async {
    if (scrollController.position.extentAfter < 200) {
      var tempResult = await youtube.nextPage();
      for (var i = 0; i < tempResult.length; i++) {
        var tempIcon = await getChannelIcon(tempResult[i].channelId!, apiKey);
        var tempViewCount = await getViewCount(tempResult[i].id!, apiKey);
        search.add(YoutubeVideoInfo(tempResult[i], tempIcon, tempViewCount));
      }
      print('Loaded next page!');
      notifyListeners();
    }
  }

  void extendHistoryVideo(YoutubeVideoInfo data) {
    int cplx = 0;
    for (int i = 0; i < historyVideo.length; i++) {
      if (data.video.id == historyVideo[i].id) cplx++;
    }
    if (cplx == 0) {
      historyVideo.add(data.video);
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
}
