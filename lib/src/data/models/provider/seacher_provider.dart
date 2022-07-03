// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:y_listener/src/core/constants/youtube_api_key.dart';
import 'package:y_listener/src/data/models/object/youtube_video_info.dart';
import 'package:y_listener/src/data/models/api/channel_icon.dart';
import 'package:y_listener/src/data/models/api/video_info.dart';
import 'package:y_listener/src/data/models/provider/api_provider.dart';
import 'package:y_listener/src/di/injector.dart';
import 'package:youtube_api/youtube_api.dart';

class SearcherProvider with ChangeNotifier {
  YoutubeAPI youtube = YoutubeAPI(keySelected, maxResults: 5);
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

  Future<void> initTrending() async {
    print("Init home screen's video...");
    try {
      trend.clear();
      trendResult = await youtube.getTrends(regionCode: region);
      trendSuccess = true;
      await generateTrendInfo();
      print('Called Trending!');
      notifyListeners();
      searcher("Nhạc remix tiktok");
    } catch (e) {
      trendSuccess = false;
      print('Exception handled!');
      print(e);
      getIt.get<APIProvider>().changeAPIKey();
      youtube.setKey = keySelected;
      initTrending();
    }
  }

  Future<void> searcher(String query) async {
    if (query == "") {
      query = "Lofi chills";
    } else {
      search.clear();
      searchSuccess = false;
      notifyListeners();
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
        notifyListeners();
      } catch (e) {
        searchSuccess = false;
        print('Exception: ');
        print(e);
        getIt.get<APIProvider>().changeAPIKey();
        youtube.setKey = keySelected;
        searcher(query);
      }
    }
  }

  Future<void> generateTrendInfo() async {
    for (var i = 0; i < trendResult.length; i++) {
      var tempIcon =
          await getChannelIcon(trendResult[i].channelId!, keySelected);
      var tempViewCount = await getViewCount(trendResult[i].id!, keySelected);
      trend.add(YoutubeVideoInfo(trendResult[i], tempIcon, tempViewCount,
          dayPublish(trendResult[i].publishedAt!)));
    }
    notifyListeners();
  }

  Future<void> generateSearchInfo() async {
    for (var i = 0; i < searchResult.length; i++) {
      var tempIcon =
          await getChannelIcon(searchResult[i].channelId!, keySelected);
      var tempViewCount = await getViewCount(searchResult[i].id!, keySelected);
      search.add(YoutubeVideoInfo(searchResult[i], tempIcon, tempViewCount,
          dayPublish(searchResult[i].publishedAt!)));
    }
    notifyListeners();
  }

  Future<void> extendSearchResult() async {
    try {
      var tempResult = await youtube.nextPage();
      for (var i = 0; i < tempResult.length; i++) {
        var tempIcon =
            await getChannelIcon(tempResult[i].channelId!, keySelected);
        var tempViewCount = await getViewCount(tempResult[i].id!, keySelected);
        search.add(YoutubeVideoInfo(tempResult[i], tempIcon, tempViewCount,
            dayPublish(tempResult[i].publishedAt!)));
      }
      print('Loaded next page!');
      notifyListeners();
    } catch (e) {
      print("\nError: extend search result - lazy load");
      getIt.get<APIProvider>().changeAPIKey();
      extendSearchResult();
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
