// ignore_for_file: no_logic_in_create_state, unnecessary_const
import 'package:flutter/material.dart';
import 'package:y_listener/models/api/channelIcon.dart';
import 'package:y_listener/models/api/youtube_api.dart';
import 'package:y_listener/screens/search_screen.dart';
import 'package:y_listener/screens/history_video_screen.dart';

//import 'package:y_listener/screens/search_screen.dart';

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

  late YoutubePlayerController _tempController;
  late YouTubeVideo tempVideoSelect;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: videoSelect.id!,
      params: YoutubePlayerParams(
        playlist: generatorPlaylist(), // Defining custom playlist
        startAt: const Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        autoPlay: true,
        playsInline: true,
        strictRelatedVideos: true,
        desktopMode: true,
      ),
    );
    super.initState();
  }

  // @override
  // void dispose() {
  //   print('Disposed');
  //   _controller.close();
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     print('Resumming...');
  //   } else {
  //     print('Paused');
  //     AppLifecycleState.resumed;
  //   }
  // }

  List<String> generatorPlaylist() {
    List<String> videoPlaylist = List.empty(growable: true);
    YouTubeVideo vid;
    for (int i = 0; i < videoResult.length; i++) {
      vid = videoResult[i];
      videoPlaylist.add(vid.id ?? "");
    }
    return videoPlaylist;
  }

  void selectVideo() {
    setState(() {
      videoSelect = tempVideoSelect;
      _controller = _tempController;
    });
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
                            videoSelect.channelId!, apiKey), // async work
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
                  videoSelect.description ?? "no description",
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
              Column(
                children: videoResult.map<Widget>(listItemFull).toList(),
              ),
            ]
                //scrollDirection: Axis.vertical,
                ),
          ),
        ],
      ),
    );
  }

  Widget listItemFull(YouTubeVideo video) {
    return InkWell(
      hoverColor: Colors.black12,
      onTap: () {
        _controller.stop();
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlayerScreen(video: video)));

        int cplx = 0;
        for (int i = 0; i < videoHistory.length; i++) {
          if (video.id == videoHistory[i].id) cplx++;
        }
        if (cplx == 0) {
          videoHistory.add(video);
        } else {}
        // print('<----URL Thumbnails---->');
        // print(video.thumbnail.high.url);
        // print(video.thumbnail.medium.url);
        // print(video.thumbnail.small.url);
        // print('<----URL Thumbnails---->');
      },
      child: Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Container(
              color: Colors.white,
              child: Image.network(
                video.thumbnail.medium.url ?? '',
                width: MediaQuery.of(context).size.width,
                scale: 0.8,
              ),
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
                  video.title,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                            future: getChannelIcon(
                                video.channelId!, apiKey), // async work
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
                              video.channelTitle +
                                  ' • ' +
                                  '38 N lượt xem' +
                                  ' • ' +
                                  '2 năm trước',
                              softWrap: true,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 50.0),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Text(
                      'Duration: ${video.duration ?? ""}',
                      softWrap: true,
                      style: const TextStyle(fontSize: 15),
                    ),
                  )),
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

  //Thumbnail nhỏ
  // Widget listItem(YouTubeVideo video) {
  //   return InkWell(
  //     hoverColor: Colors.black12,
  //     onTap: () {
  //       videoHistory.add(video);
  //       tempVideoSelect = video;

  //       int cplx = 0;
  //       for (int i = 0; i < videoHistory.length; i++) {
  //         if (video.id == videoHistory[i].id) cplx++;
  //       }

  //       if (cplx == 0) {
  //         videoHistory.add(video);
  //       } else {}

  //       _tempController = YoutubePlayerController(
  //         initialVideoId: tempVideoSelect.id!,
  //         params: YoutubePlayerParams(
  //           playlist: generatorPlaylist(), // Defining custom playlist
  //           startAt: const Duration(seconds: 0),
  //           showControls: true,
  //           showFullscreenButton: true,
  //           autoPlay: true,
  //           playsInline: true,
  //           privacyEnhanced: true,
  //           strictRelatedVideos: true,
  //         ),
  //       );
  //       selectVideo();

  //       //print(videoSelect.title);
  //     },
  //     child: Container(
  //       decoration: const BoxDecoration(),
  //       margin: const EdgeInsets.symmetric(
  //         vertical: 7.0,
  //         horizontal: 7.0,
  //       ),
  //       padding: const EdgeInsets.all(12.0),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(right: 20.0, top: 10),
  //             child: Image.network(
  //               video.thumbnail.medium.url ?? '',
  //               width: 130.0,
  //             ),
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   video.title,
  //                   softWrap: true,
  //                   style: const TextStyle(
  //                       fontSize: 15.0, fontWeight: FontWeight.bold),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 3.0),
  //                   child: Text(
  //                     video.channelTitle,
  //                     softWrap: true,
  //                     style: const TextStyle(fontSize: 14),
  //                   ),
  //                 ),
  //                 Text(
  //                   'Duration: ${video.duration ?? "00:00"} ',
  //                   style: const TextStyle(fontSize: 14),
  //                   softWrap: true,
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
