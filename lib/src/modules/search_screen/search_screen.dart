// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_listener/src/data/models/object/youtube_video_info.dart';
import 'package:y_listener/src/data/models/provider/seacher_provider.dart';
import 'package:y_listener/src/modules/player_screen/player_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    if (Provider.of<SearcherProvider>(context, listen: false).search != []) {
      Provider.of<SearcherProvider>(context, listen: false)
          .extendSearchResult(scrollController);
    }
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
        backgroundColor: Colors.red,
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
              Provider.of<SearcherProvider>(context, listen: false)
                  .queryString = text;
            },
            autofocus: false,
            onFieldSubmitted: (text) {
              if (text == "") text = "Lofi chills";
              FocusScope.of(context).requestFocus(FocusNode());
              Provider.of<SearcherProvider>(context, listen: false)
                  .searcher(text);
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
              icon: const Icon(Icons.mic),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                //callAPI();
              })
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Consumer<SearcherProvider>(
          builder: (context, value, child) {
            return Provider.of<SearcherProvider>(context, listen: false)
                    .searchSuccess
                ? ListView(
                    children:
                        Provider.of<SearcherProvider>(context, listen: false)
                            .search
                            .map<Widget>(listItemFull)
                            .toList())
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
          },
        )),
      ),
    );
  }

  Widget listItemFull(YoutubeVideoInfo data) {
    return InkWell(
      hoverColor: Colors.black12,
      onTap: () {
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                        '${data.viewCount} lượt xem • ${data.dayPublished}',
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
