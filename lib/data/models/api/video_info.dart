// To parse this JSON data, do
//
//     final videoInfor = videoInforFromJson(jsonString);

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  //Struct: 'yyy-mm-ddThh:mm:ssZ'
  late String result = '';
  DateTime current = DateTime.now();

  final year = int.parse(daytime.substring(0, 4));
  final month = int.parse(daytime.substring(5, 7));
  final day = int.parse(daytime.substring(8, 10));
  final hour = int.parse(daytime.substring(11, 13));
  final minute = int.parse(daytime.substring(14, 16));
  final second = int.parse(daytime.substring(17, 19));
  DateTime videoDay = DateTime(year, month, day, hour, minute, second);

  if (videoDay.year == current.year) {
    if (videoDay.month == current.month) {
      if (videoDay.day == current.day) {
        if (videoDay.hour == current.hour) {
          if (videoDay.minute == current.minute) {
            if (videoDay.second == current.second) {
              result = 'Vừa xong';
            } else {
              result =
                  (current.second - videoDay.second).toString() + ' giây trước';
            }
          } else {
            result =
                (current.minute - videoDay.minute).toString() + ' phút trước';
          }
        } else {
          result = (current.hour - videoDay.hour).toString() + ' giờ trước';
        }
      } else {
        result = (current.day - videoDay.day).toString() + ' ngày trước';
      }
    } else {
      result = (current.month - videoDay.month).toString() + ' tháng trước';
    }
  } else {
    result = (current.year - videoDay.year).toString() + ' năm trước';
  }
//   print(videoDay.toString());
//   print(current.toString());
//   print('Difference: $result');
  return result;
}

class PublishDay {
  int year = 0;
  int month = 0;
  int day = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;
}
