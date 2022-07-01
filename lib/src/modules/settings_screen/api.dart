import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:y_listener/src/data/models/provider/api_provider.dart';

class APIKey extends StatefulWidget {
  const APIKey({Key? key}) : super(key: key);
  @override
  _APIKeyState createState() => _APIKeyState();
}

class _APIKeyState extends State<APIKey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
        ),
        title: const Text('Y Listener'),
      ),
      body: Container(
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text('Mã API Key hiện tại',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Consumer<APIProvider>(
                    builder: (context, value, child) {
                      return Text(
                          Provider.of<APIProvider>(context).index.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold));
                    },
                  ),
                )
              ],
            ),
          ])),
    );
  }
}
