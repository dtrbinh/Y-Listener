// To parse this JSON data, do
//
//     final videoInfor = videoInforFromJson(jsonString);

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:y_listener/screens/search_screen.dart';

VideoInfor videoInforFromJson(String str) =>
    VideoInfor.fromJson(json.decode(str));

String videoInforToJson(VideoInfor data) => json.encode(data.toJson());

class VideoInfor {
  VideoInfor({
    required this.kind,
    required this.etag,
    required this.items,
    required this.pageInfo,
  });

  final String kind;
  final String etag;
  final List<Item> items;
  final PageInfo pageInfo;

  factory VideoInfor.fromJson(Map<String, dynamic> json) => VideoInfor(
        kind: json["kind"],
        etag: json["etag"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pageInfo": pageInfo.toJson(),
      };
}

class Item {
  Item({
    required this.kind,
    required this.etag,
    required this.id,
    required this.statistics,
  });

  final String kind;
  final String etag;
  final String id;
  final Statistics statistics;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        statistics: Statistics.fromJson(json["statistics"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "statistics": statistics.toJson(),
      };
}

class Statistics {
  Statistics({
    required this.viewCount,
    required this.likeCount,
    required this.favoriteCount,
    required this.commentCount,
  });

  final String viewCount;
  final String likeCount;
  final String favoriteCount;
  final String commentCount;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        viewCount: json["viewCount"],
        likeCount: json["likeCount"],
        favoriteCount: json["favoriteCount"],
        commentCount: json["commentCount"],
      );

  Map<String, dynamic> toJson() => {
        "viewCount": viewCount,
        "likeCount": likeCount,
        "favoriteCount": favoriteCount,
        "commentCount": commentCount,
      };
}

class PageInfo {
  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  final int totalResults;
  final int resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
      };
}

Future<String> getViewCount(String videoId, String apiKey) async {
  String url = '';
  late VideoInfor videoInfor;
  url = 'https://www.googleapis.com/youtube/v3/videos?id=' +
      videoId +
      '&key=' +
      apiKey +
      '&part=statistics';
  try {
    final response = await http.get(Uri.parse(url));
    videoInfor = VideoInfor.fromJson(json.decode(response.body));
  } catch (e) {
    print('Load video info err');
    return '0';
  }
  return convertCount(int.parse(videoInfor.items[0].statistics.viewCount));
}

String convertCount(int viewCount) {
  String result = '';
  if (viewCount > 0 && viewCount < 1000) {
    result = viewCount.toString();
  } else if (viewCount >= 1000 && viewCount < 1000000) {
    result = (viewCount / 1000).toStringAsFixed(1) + ' N';
  } else if (viewCount >= 1000000 && viewCount < 1000000000) {
    result = (viewCount / 1000000).toStringAsFixed(1) + ' Tr';
  } else if (viewCount >= 1000000000) {
    result = (viewCount / 1000000000).toStringAsFixed(1) + ' Tỷ';
  }
  print('Load video info success!');

  return result;
}

String dayPublish(String daytime) {
  //EX: 2021-12-29T13:00:14Z
  //Struc: yyyy-mm-dd T hh:mm:ss Z
  late String publishDay = '0';
  // phút trước
  // giờ trước
  // ngày trước
  // tháng trước
  // năm trước
  return publishDay;
}
