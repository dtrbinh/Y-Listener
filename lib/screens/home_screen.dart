// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:y_listener/data/models/api/video_info.dart';
import 'package:y_listener/data/models/object/youTubeVideoInfo.dart';
import 'package:y_listener/data/models/provider/app_variable.dart';
import 'package:y_listener/screens/settings/settings_screen.dart';

import 'package:youtube_api/youtube_api.dart';

import 'package:y_listener/screens/history_video_screen.dart';
import 'package:y_listener/screens/search_screen.dart';
import 'package:y_listener/screens/player_screen.dart';
import 'package:y_listener/screens/settings/API.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  YoutubeAPI youtube = YoutubeAPI(apiKey);

  @override
  void initState() {
    Provider.of<AppVariable>(context, listen: false).callDefaultAPI();
    super.initState();
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
                //color: Color.fromRGBO(255, 0, 0, 1),
              ),
            ),
            //Homepage
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
            //Profile
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
            //History
            ListTile(
              leading: const Icon(Icons.history_edu),
              title: const Text(
                'Lịch sử',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const HistoryScreen()));
              },
            ),
            //Settings
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Cài đặt',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const Settings()));
              },
            ),
            const Divider(
              height: 10,
              thickness: 1,
            ),
            //Logout
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                //Quay về hompage
                Navigator.pop(context);
              },
            ),
            //Quit app
            ListTile(
              leading: const Icon(Icons.subdirectory_arrow_left_sharp),
              title: const Text(
                'Thoát',
                style: TextStyle(fontSize: 17),
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
        backgroundColor: Colors.red,
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
        ],
      ),
      //Trending video
      body: RefreshIndicator(
          onRefresh:
              Provider.of<AppVariable>(context, listen: false).callDefaultAPI,
          child: Consumer<AppVariable>(
            builder: (context, value, child) {
              return ListView(
                children: Provider.of<AppVariable>(context, listen: false)
                    .trend
                    .map<Widget>(listItemFull)
                    .toList(),
              );
            },
          )),
    );
  }

  Widget listItemFull(YoutubeVideoInfo data) {
    return InkWell(
      hoverColor: Colors.black12,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlayerScreen(video: data.video)));
        Provider.of<AppVariable>(context, listen: false)
            .extendHistoryVideo(data);
      },
      child: Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
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
            ),
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
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    data.viewCount +
                        ' lượt xem ' '• ' +
                        dayPublish(data.video.publishedAt!),
                    //'28 N lượt xem' ' • ' '2 năm trước',
                    softWrap: true,
                    style: const TextStyle(fontSize: 15),
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 0.0, top: 10),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(
                                  data.channelIconURL,
                                ),
                                backgroundColor: Colors.black12,
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
                                      data.video.channelTitle,
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
