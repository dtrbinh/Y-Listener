// ignore_for_file: no_logic_in_create_state, unnecessary_const, avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_listener/src/core/constants/youtube_api_key.dart';
import 'package:y_listener/src/data/models/api/channel_icon.dart';
import 'package:y_listener/src/data/models/api/video_info.dart';
import 'package:y_listener/src/data/models/object/youtube_video_info.dart';
import 'package:y_listener/src/data/models/provider/seacher_provider.dart';
import 'package:y_listener/src/modules/video%20history/history_video_screen.dart';

import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key, required this.video}) : super(key: key);
  final YouTubeVideo video;

  @override
  _PlayerScreenState createState() => _PlayerScreenState(video);
}

class _PlayerScreenState extends State<PlayerScreen> {
  _PlayerScreenState(this.videoSelect);

  late YoutubePlayerController _controller;
  late YouTubeVideo videoSelect;

  @override
  void initState() {
    print('Generating...');
    _controller = YoutubePlayerController(
      initialVideoId: videoSelect.id!,
      params: const YoutubePlayerParams(
        playlist: [], // Defining custom playlist
        startAt: Duration.zero,
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
        desktopMode: true,
        autoPlay: true,
      ),
    );
    print('Generated!');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
        ),
        title: const Text('Y Listener'),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 100),
        actions: <Widget>[
          //Thanh tìm kiếm
          //Trang video lịch sử
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History video',
            onPressed: () {
              _controller.pause();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HistoryScreen()));
              //Gọi history video
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
              color: Colors.black12,
              width: MediaQuery.of(context).size.width,
              child: YoutubePlayerControllerProvider(
                  controller: _controller,
                  child: YoutubePlayerIFrame(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                  ))),
          Expanded(
            child: ListView(shrinkWrap: true, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                child: Text(
                  videoSelect.title,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                height: 5,
                thickness: 1,
                color: Colors.transparent,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 00,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.volunteer_activism_outlined)),
                                const Text('Like'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon:
                                        const Icon(Icons.clean_hands_outlined)),
                                const Text('Dislike'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.chat_outlined)),
                                const Text('Comments'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.share)),
                                const Text('Share'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.flag_outlined)),
                                const Text('Report'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.download_outlined)),
                                const Text('Download'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_box_outlined)),
                                const Text('Add to library'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 1,
                color: Colors.transparent,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                child: Divider(
                  height: 20,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 5),
                      child: FutureBuilder<String>(
                        future: getChannelIcon(
                            videoSelect.channelId!, keySelected), // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(
                                    'assets/img/loading-buffering.gif'),
                                backgroundColor: Colors.white,
                              );
                            default:
                              if (snapshot.hasError) {
                                return const CircleAvatar(
                                  radius: 18,
                                  backgroundImage:
                                      AssetImage('assets/img/alert.gif'),
                                  backgroundColor: Colors.white,
                                );
                              } else {
                                return CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(
                                    snapshot.data!,
                                  ),
                                  backgroundColor: Colors.black12,
                                );
                              }
                          }
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: Text(
                                videoSelect.channelTitle,
                                softWrap: true,
                                style: const TextStyle(fontSize: 18),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.only(left: 15.0, top: 5),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: Text(
                                '62 N người đăng ký',
                                softWrap: true,
                                style: TextStyle(fontSize: 15),
                              ),
                            )),
                      ],
                    ),
                    const Spacer(flex: 10),
                    TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                          child: Container(
                            color: Colors.white,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(185, 31, 31, 1),
                                ),
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(' '),
                                    Icon(
                                      Icons.notification_add_outlined,
                                      color: Colors.white,
                                    ),
                                    Center(
                                      child: Text(
                                        '  Đăng ký  ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                child: Text(
                  videoSelect.description ?? "No description",
                  style: const TextStyle(fontSize: 16),
                  softWrap: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                child: Divider(
                  height: 30,
                  thickness: 1,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                  child: Divider(
                    height: 0,
                    thickness: 0,
                    color: Colors.transparent,
                  )),
              Consumer<SearcherProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: value.search.map<Widget>(listItemFull).toList(),
                  );
                },
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget listItemFull(YoutubeVideoInfo data) {
    return InkWell(
      hoverColor: Colors.black12,
      onTap: () {
        _controller.stop();
        //Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlayerScreen(video: data.video)));
        Provider.of<SearcherProvider>(context, listen: false)
            .extendHistoryVideo(data);
      },
      child: Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Image.network(
                    data.video.thumbnail.medium.url ?? '',
                    width: MediaQuery.of(context).size.width,
                    scale: 0.8,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      width: 60,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          data.video.duration ?? '',
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ))),
                ),
              ],
            )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  data.video.title,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: FutureBuilder<String>(
                  future:
                      getViewCount(data.video.id!, keySelected), // async work
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Text(
                          '',
                          softWrap: true,
                          style: TextStyle(fontSize: 17),
                        );
                      default:
                        if (snapshot.hasError) {
                          return const Text(
                            '',
                            softWrap: true,
                            style: TextStyle(fontSize: 17),
                          );
                        } else {
                          return Text(
                            '${snapshot.data!} lượt xem • ${dayPublish(data.video.publishedAt!)}',
                            //'28 N lượt xem' ' • ' '2 năm trước',
                            softWrap: true,
                            style: const TextStyle(fontSize: 17),
                          );
                        }
                    }
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 0.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder<String>(
                            future: getChannelIcon(data.video.channelId!,
                                keySelected), // async work
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const CircleAvatar(
                                    radius: 15,
                                    backgroundImage: AssetImage(
                                        'assets/img/loading-buffering.gif'),
                                    backgroundColor: Colors.white,
                                  );
                                default:
                                  if (snapshot.hasError) {
                                    return const CircleAvatar(
                                      radius: 15,
                                      backgroundImage:
                                          AssetImage('assets/img/alert.gif'),
                                      backgroundColor: Colors.white,
                                    );
                                  } else {
                                    return CircleAvatar(
                                      radius: 15,
                                      backgroundImage: NetworkImage(
                                        snapshot.data!,
                                      ),
                                      backgroundColor: Colors.black12,
                                    );
                                  }
                              }
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              data.video.channelTitle,
                              softWrap: true,
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                          // Container(
                          //     child: Padding(
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 10, vertical: 0),
                          //       child: Text(
                          //         'Duration: ${video.duration ?? ""}',
                          //         softWrap: true,
                          //         style: const TextStyle(fontSize: 15),
                          //       ),
                          //     )),
                        ],
                      ))),
            ]),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Divider(
              height: 10,
              thickness: 1,
              color: Colors.transparent,
            ),
          ),
        ]),
      ),
    );
  }
}
