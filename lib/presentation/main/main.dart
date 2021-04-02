import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reservation_manager/presentation/next_page/next_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_manager/presentation/reservation_list/reservation_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    final items = List<String>.generate(10000, (i) => "Item $i");
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: Icon(Icons.videocam_off_rounded),
            title: const Text(
              'YouTubeアプリ',
            ),
            actions: [
              SizedBox(
                width: 40,
                child: FlatButton(
                  child: Icon(Icons.search),
                  onPressed: () {
                    // TODO
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: FlatButton(
                  child: Icon(Icons.more_vert),
                  onPressed: () {
                    // TODO
                  },
                ),
              ),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          'images/y.jpg',
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: [
                          const Text('今日のフクロウ日記'),
                          FlatButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.video_call,
                                  color: Colors.red,
                                ),
                                Text('登録する'),
                              ],
                            ),
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReservationListPage()),
                          );
                        },
                        contentPadding: EdgeInsets.all(8),
                        leading: Image.asset(
                          'images/y.jpg',
                        ),
                        title: Column(
                          children: [
                            Text(
                              '【今日の天気】本日の東京の天気を振り返ります${[index]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '34万回再生',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  '1週間前',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: Icon(Icons.more_vert),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
