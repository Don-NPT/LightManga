// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LightNovelDetail extends StatelessWidget {
  final Map<dynamic, dynamic> lightnovel;

  _launchURL(String url) async {
    // const url = 'https://www.google.com';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  // ignore: use_key_in_widget_constructors
  const LightNovelDetail({
    required this.lightnovel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 242, 255),
      appBar: AppBar(
        title: Text(lightnovel['name']),
        backgroundColor: const Color.fromARGB(255, 204, 242, 255),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Card(
            child: Column(
              children: <Widget>[
                Image.network(
                  lightnovel['img'],
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const Text("Title",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(
                    lightnovel['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
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
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              for (var i = 0; i < lightnovel['tag'].length; i++)
                                Container(
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 204, 242, 255),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    margin: const EdgeInsets.all(3),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(lightnovel['tag'][i]),
                                    )),
                            ]),
                      ],
                    )),

                // SizedBox(
                //   height: 20,
                //   child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       physics: const NeverScrollableScrollPhysics(),
                //       shrinkWrap: true,
                //       itemCount: lightnovel['tag'].length,
                //       itemBuilder: (BuildContext context, int index) {
                //         return Row(
                //           children: [
                //             Container(
                //                 height: 200,
                //                 decoration: BoxDecoration(
                //                     border: Border.all(
                //                       color: Colors.cyan,
                //                     ),
                //                     borderRadius: const BorderRadius.all(
                //                         Radius.circular(20))),
                //                 padding: const EdgeInsets.symmetric(
                //                     vertical: 0, horizontal: 6),
                //                 child: Align(
                //                   alignment: Alignment.center,
                //                   child: Text(lightnovel['tag'][index]),
                //                 )),
                //             const SizedBox(
                //               width: 10,
                //             )
                //           ],
                //         );
                //       }),
                // ),
                ListTile(
                  title: const Text("Author",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(
                    lightnovel['author'],
                    textAlign: TextAlign.center,
                  ),
                ),
                const Text("Volume",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 300,
                    child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        children: [
                          for (var i = 0; i < lightnovel['volume']; i++)
                            const Icon(Icons.book)
                        ])),
                ListTile(
                  title: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text("Synopsis",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  subtitle: Text(lightnovel['synopsis']),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Check Prices",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _launchURL(lightnovel['se-ed']),
                      child: const Text("SE-ED"),
                    ),
                    ElevatedButton(
                      onPressed: () => _launchURL(lightnovel['naiin']),
                      child: const Text("NAIIN"),
                    ),
                    ElevatedButton(
                      onPressed: () => _launchURL(lightnovel['shopee']),
                      child: const Text("SHOPEE"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
