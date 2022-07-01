// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_listener/src/data/models/provider/seacher_provider.dart';
import 'package:y_listener/src/modules/player_screen/player_screen.dart';
import 'package:youtube_api/youtube_api.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        backgroundColor: Colors.red,
        title: const Text('Video đã xem'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<SearcherProvider>(context, listen: false)
                    .deleteVideoHistory();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Container(
          color: Colors.white,
          child: Consumer<SearcherProvider>(
            builder: (context, value, child) {
              return ListView(
                children: value.historyVideo.map<Widget>(listItem).toList(),
              );
            },
          )),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlayerScreen(video: video)));

        //print(video.thumbnail.medium.url);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.network(
                video.thumbnail.medium.url ?? '',
                width: 120.0,
                scale: 0.8,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video.title,
                    softWrap: true,
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      video.channelTitle,
                      softWrap: true,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Duration: ${video.duration!}',
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
