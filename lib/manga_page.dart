import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lightmanga/manga_detail.dart';
import 'package:lightmanga/manga_object.dart';

Future<List<Manga>> getManga() async {
  // Base headers for Response url
  const Map<String, String> _headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "manga-scrapper-for-asura-scans-website.p.rapidapi.co",
    "x-rapidapi-key": "YOUR-API-KEY",
  };

  Response response = await get(
      Uri.parse(
          'https://manga-scrapper-for-asura-scans-website.p.rapidapi.com/series'),
      headers: _headers);

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);

    List<Manga> mangas =
        body.map((dynamic item) => Manga.fromJson(item)).toList();

    return mangas;
  } else {
    throw Exception('Failed to load manga');
  }
}

class MangaPage extends StatefulWidget {
  const MangaPage({Key? key}) : super(key: key);

  @override
  _MangaPageState createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  late Future<List<Manga>> futureManga;

  @override
  void initState() {
    super.initState();
    futureManga = getManga();
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Light Novel'),
              onTap: () {
                Navigator.pushNamed(context, '/lightnovel');
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
          future: futureManga,
          builder: (BuildContext context, AsyncSnapshot<List<Manga>> snapshot) {
            if (snapshot.hasData) {
              List<Manga>? mangas = snapshot.data;
              return ListView(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                children: mangas!
                    .map(
                      (Manga manga) => InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MangaDetail(manga: manga))),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(manga.seriesTitle,
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
                                    manga.coverImage,
                                    width: 150,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 20,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // physics:
                                      //     const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: manga.genre.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.cyan,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 6),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child:
                                                      Text(manga.genre[index]),
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  subtitle: Text(
                                    manga.synopsis,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 1,
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.grey),
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
