import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  // กำนหดตัวแปรข้อมูล articles
  late Future<List<Article>> articles;
  // ตัว ScrollController สำหรับจัดการการ scroll ใน ListView
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    articles = fetchArticle();
  }

  Future<void> _refresh() async {
    setState(() {
      articles = fetchArticle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: FutureBuilder<List<Article>>( // ชนิดของข้อมูล
          future: articles, // ข้อมูล Future
          builder: (context, snapshot) {
            // มีข้อมูล และต้องเป็น done ถึงจะแสดงข้อมูล ถ้าไม่ใช่ ก็แสดงตัว loading
            if (snapshot.hasData) {
              bool _visible = false; // กำหนดสถานะการแสดง หรือมองเห็น เป็นไม่แสดง
              if(snapshot.connectionState == ConnectionState.waiting){ // เมื่อกำลังรอข้อมูล
                _visible = true; // เปลี่ยนสถานะเป็นแสดง
              }
              if(_scrollController.hasClients){ //เช็คว่ามีตัว widget ที่ scroll ได้หรือไม่ ถ้ามี
                // เลื่อน scroll มาด้านบนสุด
                _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
              }
              return Column(
                children: [
                  Visibility(
                    child: const LinearProgressIndicator(),
                    visible: _visible,
                  ),
                  Container( // สร้างส่วน header ของลิสรายการ
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.withAlpha(100),
                    ),
                    child: Row(
                      children: [
                        Text('Total ${snapshot.data!.length} items'), // แสดงจำนวนรายการ
                      ],
                    ),
                  ),
                  Expanded( // ส่วนของลิสรายการ
                    child: snapshot.data!.isNotEmpty // กำหนดเงื่อนไขตรงนี้
                        ? RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated( // กรณีมีรายการ แสดงปกติ
                        controller: _scrollController, // กำนหนด controller ที่จะใช้งานร่วม
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Article article = snapshot.data![index];

                          Widget card; // สร้างเป็นตัวแปร
                          card = Card(
                              margin: const EdgeInsets.all(5.0), // การเยื้องขอบ
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(article.title),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text('Like'),
                                        onPressed: () {/* ... */},
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        child: const Text('Comment'),
                                        onPressed: () {/* ... */},
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Container(
                                          color: Colors.orange.withAlpha(50),
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            child: const Text('Share'),
                                            onPressed: () {/* ... */},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          );
                          return card;
                        },
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(),
                      ),
                    )
                        : const Center(child: Text('No items')), // กรณีไม่มีรายการ
                  ),
                ],
              );
            } else if (snapshot.hasError) { // กรณี error
              return Text('${snapshot.error}');
            }
            // กรณีสถานะเป็น waiting ยังไม่มีข้อมูล แสดงตัว loading
            return const RefreshProgressIndicator();
          },
        ),
      ),
    );
  }

}

// สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ Article
Future<List<Article>> fetchArticle() async {
  // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  // เมื่อมีข้อมูลกลับมา
  if (response.statusCode == 200) {
    // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Article
    // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parseArticles
    // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
    return compute(parseArticles, response.body);
  } else { // กรณี error
    throw Exception('Failed to load article');
  }
}

// ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<Article>
List<Article> parseArticles(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}

// Data models
class Article {
  final int userId;
  final int id;
  final String title;
  final String body;

  Article({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // ส่วนของ name constructor ที่จะแปลง json string มาเป็น Article object
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

}