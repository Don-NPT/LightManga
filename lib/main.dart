import 'package:flutter/material.dart';
import 'package:lightmanga/lightnovel_page.dart';
import 'package:lightmanga/manga_page.dart';

void main() => runApp(MaterialApp(
        title: 'LightManga',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          // scaffoldBackgroundColor: Colors.grey[300],
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const MangaPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/lightnovel': (context) => const LightNovelPage(),
        }));
