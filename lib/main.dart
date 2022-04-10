import 'package:flutter/material.dart';
import 'package:lightmanga/map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lightmanga/lightnovel_page.dart';
import 'firebase_options.dart';
import 'manga_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
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
        '/map': (context) => const Map(),
        // '/test': (context) => const Test()
      }));
}
