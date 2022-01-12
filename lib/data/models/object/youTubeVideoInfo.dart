// ignore_for_file: file_names

import 'package:youtube_api/youtube_api.dart';

class YoutubeVideoInfo {
  late YouTubeVideo video;
  late String channelIconURL = '';
  late String viewCount = '';
  YoutubeVideoInfo(this.video, this.channelIconURL, this.viewCount);
}
