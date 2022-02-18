import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lightmanga/lightnovel_object.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<LightNovel>> getNovel() async {
  // Base headers for Response url
  const Map<String, String> _headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "upcoming-light-novels.p.rapidapi.com",
    "x-rapidapi-key": "YOUR-API-KEY",
  };

  Response response = await get(
      Uri.parse('https://upcoming-light-novels.p.rapidapi.com/lns/yenpress'),
      headers: _headers);

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);

    List<LightNovel> novels =
        body.map((dynamic item) => LightNovel.fromJson(item)).toList();

    return novels;
  } else {
    throw Exception('Failed to load novels');
  }
}

_launchURL(String url) async {
  // const url = 'https://www.google.com';
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

class LightNovelPage extends StatefulWidget {
  const LightNovelPage({Key? key}) : super(key: key);

  @override
  _LightNovelPageState createState() => _LightNovelPageState();
}

class _LightNovelPageState extends State<LightNovelPage> {
  late Future<List<LightNovel>> futureNovel;

  @override
  void initState() {
    super.initState();
    futureNovel = getNovel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(
            Icons.book,
            color: Colors.cyan,
          ),
          Text(
            '  LightManga',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ]),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Text('LightManga Menu'),
            ),
            ListTile(
              title: const Text('Manga'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: const Text('Light Novel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Find Bookstore'),
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: futureNovel,
          builder:
              (BuildContext context, AsyncSnapshot<List<LightNovel>> snapshot) {
            if (snapshot.hasData) {
              List<LightNovel>? mangas = snapshot.data;
              return ListView(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                children: mangas!
                    .map(
                      (LightNovel manga) => InkWell(
                          // onTap: () => null,
                          child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(manga.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 15,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                manga.img,
                                width: 150,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () => _launchURL(manga.url),
                              child: const Text("Go to Website"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      )),
                    )
                    .toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
