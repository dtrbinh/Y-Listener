import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'language.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
        title: const Text('Cài đặt'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const APIKey()));
              },
              child: const Text(
                'API KEY',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(
              height: 30,
              thickness: 1,
              color: Colors.black45,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const ChangeLanguage()));
              },
              child: const Text(
                'Ngôn ngữ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(
              height: 30,
              thickness: 1,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
