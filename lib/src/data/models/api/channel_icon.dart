// To parse this JSON data, do
//
//  final channelIcon = channelIconFromJson(jsonString);

// ignore_for_file: avoid_print

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
  late ChannelIcon channelIcon;
  urlJSON = 'https://www.googleapis.com/youtube/v3/channels?part=snippet&id=$channelID&fields=items%2Fsnippet%2Fthumbnails&key=$apiKey';
  try {
    final response = await http.get(Uri.parse(urlJSON));
    channelIcon = ChannelIcon.fromMap(json.decode(response.body));
  } catch (e) {
    print('Load icon error');
    return 'data:image/png;base64,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';
  }
  print('Load icon success!');
  return channelIcon.items[0].snippet.thumbnails.thumbnailsDefault.url;
}
