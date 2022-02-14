import 'package:flutter/material.dart';
import 'package:lightmanga/main.dart';

class MangaDetail extends StatelessWidget {
  final Manga manga;

  const MangaDetail({
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(manga.seriesTitle),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      manga.coverImage,
                      width: 300,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Padding(
                        padding: EdgeInsets.all(10),
                        child: const Text("Synopsis",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
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
                    )
                  ],
                ),
              ))),
    );
  }
}
