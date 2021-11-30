import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String queryString = "";

String key1 = "AIzaSyCMReGgd5e9a7sC_PSJP0QfCYcKlT2IGNM";
String key2 = "AIzaSyCnCWwipdHNQRseB1jRleb5cidq9beGXPw";
String key3 = "AIzaSyA4_vhWhIYklMO8hj6ZN0_tL9oF5lVmVlE";
String key4 = "AIzaSyD-iUt1LQim7vtV5em1Q9Q9Gh1N-eLC-EQ";
String key5 = "AIzaSyD_gaeHM8hK-p5Y1sb1Wub1Y0QOWbKSDuw";

//---
//API key được dùng
String apiKey = "AIzaSyCMReGgd5e9a7sC_PSJP0QfCYcKlT2IGNM";
int state = 1;
int tempState = 1;

class APIKey extends StatefulWidget {
  const APIKey({Key? key}) : super(key: key);

  @override
  _APIKeyState createState() => _APIKeyState();
}

class _APIKeyState extends State<APIKey> {
  void checkAPIState() {
    setState(() {
      state = tempState;
    });

    switch (state) {
      case 1:
        apiKey = key1;
        break;
      case 2:
        apiKey = key2;
        break;
      case 3:
        apiKey = key3;
        break;
      case 4:
        apiKey = key4;
        break;
      case 5:
        apiKey = key5;
        break;
      default:
        apiKey = "AIzaSyCMReGgd5e9a7sC_PSJP0QfCYcKlT2IGNM";
        break;
    }
  }

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
                  child: Text(state.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text('Chọn API Key khác',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                          border: Border.all(
                            color: Colors.black,
                            width: 0.1,
                            style: BorderStyle.solid,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  1, 3), // changes position of shadow
                            ),
                          ]),
                      width: 60,
                      height: 40,
                      child: IconButton(
                        hoverColor: Colors.black,
                        color: Colors.white,
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          Colors.black;
                          switch (state) {
                            case 1:
                              tempState = 2;
                              break;
                            case 2:
                              tempState = 3;
                              break;
                            case 3:
                              tempState = 4;
                              break;
                            case 4:
                              tempState = 5;
                              break;
                            case 5:
                              tempState = 1;
                              break;
                            default:
                              tempState = 1;
                              break;
                          }
                          checkAPIState();
                        },
                      ),
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red[50],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Center(
                        child: Text('API KEY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      apiKey,
                      style: const TextStyle(fontSize: 18),
                      softWrap: true,
                    ),
                  )
                ],
              ),
            )
          ])),
    );
  }
}
