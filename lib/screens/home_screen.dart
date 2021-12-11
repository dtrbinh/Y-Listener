// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youtube_api/youtube_api.dart';

import 'package:y_listener/screens/history_video_screen.dart';
import 'package:y_listener/screens/search_screen.dart';
import 'package:y_listener/screens/player_screen.dart';
import 'package:y_listener/models/api/youtube_api.dart';
import 'package:y_listener/models/api/channelIcon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  YoutubeAPI youtube = YoutubeAPI(apiKey);
  late List<YouTubeVideo> listDefault = [];
  late List<YouTubeVideo> tempListDefault = [];

  @override
  void initState() {
    callDefaultAPI();
    super.initState();
  }

  Future<void> callDefaultAPI() async {
    try {
      tempListDefault = await youtube.getTrends(regionCode: 'VN');
    } catch (e) {
      print('Exception handled!');
      print(e);
      changeAPI();
      callDefaultAPI();
    }
    print('Called Trending!');
    setState(() {
      listDefault = tempListDefault;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP._w8gaLDAT6IhF_V1omS0DQHaHy?pid=ImgDet&rs=1'),
              ),
              accountEmail: Text("dotranbinhqng02@gmail.com"),
              accountName: Text(
                'Do Tran Binh',
                style: TextStyle(fontSize: 20),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Trang chủ',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                //Quay về hompage
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                //Thông tin profile
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history_edu),
              title: const Text(
                'Lịch sử tìm kiếm',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                //Quay về hompage
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Cài đặt',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                //Quay về hompage
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const APIKey()));
              },
            ),
            const Divider(
              height: 10,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                //Quay về hompage
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.subdirectory_arrow_left_sharp),
              title: const Text(
                'Thoát',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                //Quay về hompage
                SystemNavigator.pop();
                //Xoá chạy nền
                //exit(0);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        title: const Text('Y Listener'),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 100),
        actions: <Widget>[
          //Thanh tìm kiếm
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Open Seach Bar',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchScreen()));
              //gọi đến search screen
            },
          ),
          // IconButton(
          //     onPressed: () {
          //       callDefaultAPI();
          //       setState(() {
          //         listDefault = tempListDefault;
          //       });
          //     },
          //     icon: const Icon(Icons.replay_outlined)),
          //Trang video lịch sử
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History video',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HistoryScreen()));
              //Gọi history video
            },
          ),
        ],
      ),
      //Trending video
      body: Center(
        child: ListView(
          children: listDefault.map<Widget>(listItemFull).toList(),
        ),
      ),
    );
  }

    Widget listItemFull(YouTubeVideo video) {
    return InkWell(
      hoverColor: Colors.black12,
      onTap: () {
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
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  '28 N lượt xem' ' • ' '2 năm trước',
                  softWrap: true,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 0.0, top: 10),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 15.0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: Text(
                                      video.channelTitle,
                                      softWrap: true,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  )),
                              Container(
                                  margin:
                                      const EdgeInsets.only(left: 15.0, top: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: Text(
                                      'Duration: ${video.duration ?? ""}',
                                      softWrap: true,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ))),
            ]),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            color: Colors.transparent,
          ),
        ]),
      ),
    );
  }
}
