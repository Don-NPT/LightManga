import 'package:flutter/material.dart';
import 'package:lightmanga/manga_object.dart';

class MangaDetail extends StatelessWidget {
  final Manga manga;

  // ignore: use_key_in_widget_constructors
  const MangaDetail({
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(manga.seriesTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Card(
        child: Column(
          children: <Widget>[
            Image.network(
              manga.coverImage,
              width: 400,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Title",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              subtitle: Text(manga.seriesTitle),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Synopsis",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              subtitle: Text(manga.synopsis),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Genre",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: manga.genre.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [Text(manga.genre[index] + "  ")],
                    );
                  }),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Updated at:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              subtitle: Text(manga.updated_at),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
