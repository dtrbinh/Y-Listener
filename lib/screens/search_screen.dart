// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:y_listener/screens/player_screen.dart';
import 'package:y_listener/utils/youtube_api.dart';
import 'package:y_listener/models/api/channel_icon.dart';
import 'package:y_listener/screens/history_video_screen.dart';
import 'package:y_listener/screens/settings/API.dart';
import 'package:y_listener/models/api/video_info.dart';

List<YouTubeVideo> videoResult = [];


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  YoutubeAPI youtube = YoutubeAPI(apiKey);
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        scrollListener();
      });
    super.initState();
  }

  Future<void> scrollListener() async {
    List<YouTubeVideo> tempVideoResult = [];

    if (videoResult != []) {
      if (scrollController.position.extentAfter < 200) {
        tempVideoResult = [];
        tempVideoResult = videoResult + await youtube.nextPage();
        setState(() {
          videoResult = tempVideoResult;
        });
        print('Loaded next page!');
      }
    }
  }

  Future<void> callAPI() async {
    List<YouTubeVideo> searchResult = [];
    String query;

    if (queryString != '') {
      query = queryString;
    } else {
      query = 'Chill Songs';
    }
    print('Searching: ' + query);
    try {
      searchResult = await youtube.search(
        query,
        type: 'video, playlist',
        //date, rating, relevance, title, videoCount, viewCount
        order: 'relevance',
        videoDuration: 'any',
        regionCode: 'VN',
      );
    } catch (e) {
      print('Exception handled!');
      print(e);
      changeAPI();
      youtube = YoutubeAPI(apiKey);
      callAPI();
    }
    print("Searched!");
    //searchResult = await youtube.nextPage();
    setState(() {
      videoResult = searchResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 100),
        title: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            maxLines: 1,
            onChanged: (text) {
              queryString = text;
              if (text == "") text = "Chill Songs";
            },
            autofocus: false,
            onFieldSubmitted: (text) {
              if (text == "") text = "Chill Songs";
              FocusScope.of(context).requestFocus(FocusNode());
              callAPI();
              //Hàm search + hiển thị kq
            },
            textAlign: TextAlign.left,
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm',
              icon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 18),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                //Tìm kiếm và hiển thị kq
                FocusScope.of(context).requestFocus(FocusNode());
                callAPI();
              })
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            controller: scrollController,
            children: videoResult.map<Widget>(listItemFull).toList(),
          ),
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
                    video.thumbnail.medium.url ?? '',
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
                          video.duration ?? '',
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
                  video.title,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: FutureBuilder<String>(
                  future: getViewCount(video.id!, apiKey), // async work
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Text(
                          '',
                          softWrap: true,
                          style: TextStyle(fontSize: 15),
                        );
                      default:
                        if (snapshot.hasError) {
                          return const Text(
                            '',
                            softWrap: true,
                            style: TextStyle(fontSize: 15),
                          );
                        } else {
                          return Text(
                            snapshot.data! + ' lượt xem ' '• ' + dayPublish(video.publishedAt!) ,
                            //'28 N lượt xem' ' • ' '2 năm trước',
                            softWrap: true,
                            style: const TextStyle(fontSize: 15),
                          );
                        }
                    }
                  },
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
