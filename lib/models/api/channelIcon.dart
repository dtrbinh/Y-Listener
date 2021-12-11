// To parse this JSON data, do
//
//  final channelIcon = channelIconFromJson(jsonString);

// ignore_for_file: avoid_print, file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

ChannelIcon channelIconFromMap(String str) =>
    ChannelIcon.fromMap(json.decode(str));

String channelIconToMap(ChannelIcon data) => json.encode(data.toMap());

class ChannelIcon {
  ChannelIcon({
    required this.items,
  });

  final List<Item> items;

  factory ChannelIcon.fromMap(Map<String, dynamic> json) => ChannelIcon(
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class Item {
  Item({
    required this.snippet,
  });

  final Snippet snippet;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        snippet: Snippet.fromMap(json["snippet"]),
      );

  Map<String, dynamic> toMap() => {
        "snippet": snippet.toMap(),
      };
}

class Snippet {
  Snippet({
    required this.thumbnails,
  });

  final Thumbnails thumbnails;

  factory Snippet.fromJson(String str) => Snippet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Snippet.fromMap(Map<String, dynamic> json) => Snippet(
        thumbnails: Thumbnails.fromMap(json["thumbnails"]),
      );

  Map<String, dynamic> toMap() => {
        "thumbnails": thumbnails.toMap(),
      };
}

class Thumbnails {
  Thumbnails({
    required this.thumbnailsDefault,
    required this.medium,
    required this.high,
  });

  final Default thumbnailsDefault;
  final Default medium;
  final Default high;

  factory Thumbnails.fromJson(String str) =>
      Thumbnails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Thumbnails.fromMap(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault: Default.fromMap(json["default"]),
        medium: Default.fromMap(json["medium"]),
        high: Default.fromMap(json["high"]),
      );

  Map<String, dynamic> toMap() => {
        "default": thumbnailsDefault.toMap(),
        "medium": medium.toMap(),
        "high": high.toMap(),
      };
}

class Default {
  Default({
    required this.url,
    required this.width,
    required this.height,
  });

  final String url;
  final int width;
  final int height;

  factory Default.fromJson(String str) => Default.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Default.fromMap(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

Future<String> getChannelIcon(String channelID, String apiKey) async {
  String urlJSON = '';
  urlJSON = 'https://www.googleapis.com/youtube/v3/channels?part=snippet&id=' +
      channelID +
      '&fields=items%2Fsnippet%2Fthumbnails&key=' +
      apiKey;
  //print(urlJSON);
  final response = await http.get(Uri.parse(urlJSON));
  final channelIcon = ChannelIcon.fromMap(json.decode(response.body));
  // print('called API');
  // print('-----------------');
  // print(response.body);
  // print('URL Image here: ');
  // print(channelIcon.items[0].snippet.thumbnails.medium.url);

  return channelIcon.items[0].snippet.thumbnails.thumbnailsDefault.url;
}
