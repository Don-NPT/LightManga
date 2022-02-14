import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lightmanga/manga_detail.dart';

Future<List<Manga>> getManga() async {
  // Base headers for Response url
  const Map<String, String> _headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "manga-scrapper-for-asura-scans-website.p.rapidapi.co",
    "x-rapidapi-key": "9489183d43mshe8516f5a6ccea65p13fe37jsn30787f2b9310",
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
    throw Exception('Failed to load album');
  }
}

class Manga {
  final int seriesId;
  final String seriesTitle;
  final String seriesSlug;
  final String coverImage;
  final String synopsis;
  final List<dynamic> genre;
  final String selfUrl;
  final String chaptersUrl;
  final String sourceUrl;
  final String created_at;
  final String updated_at;

  const Manga({
    required this.seriesId,
    required this.seriesTitle,
    required this.seriesSlug,
    required this.coverImage,
    required this.synopsis,
    required this.genre,
    required this.selfUrl,
    required this.chaptersUrl,
    required this.sourceUrl,
    required this.created_at,
    required this.updated_at,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      seriesId: json['seriesId'] as int,
      seriesTitle: json['seriesTitle'] as String,
      seriesSlug: json['seriesSlug'] as String,
      coverImage: json['coverImage'] as String,
      synopsis: json['synopsis'] as String,
      genre: json['genre'] as List<dynamic>,
      selfUrl: json['selfUrl'] as String,
      chaptersUrl: json['chaptersUrl'] as String,
      sourceUrl: json['sourceUrl'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Manga>> futureManga;

  @override
  void initState() {
    super.initState();
    futureManga = getManga();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LightManga',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[100]),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LightManga'),
        ),
        body: Center(
          child: FutureBuilder(
            future: futureManga,
            builder:
                (BuildContext context, AsyncSnapshot<List<Manga>> snapshot) {
              if (snapshot.hasData) {
                List<Manga>? mangas = snapshot.data;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  children: mangas!
                      .map(
                        (Manga manga) => Card(
                            child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MangaDetail(manga: manga))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(manga.seriesTitle,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Image.network(
                                        manga.coverImage,
                                        width: 200,
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
                                    ],
                                  ),
                                ))),
                      )
                      .toList(),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
