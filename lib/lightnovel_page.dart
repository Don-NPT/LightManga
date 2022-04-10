import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'lightnovel_detail.dart';

class LightNovelPage extends StatefulWidget {
  const LightNovelPage({Key? key}) : super(key: key);

  @override
  State<LightNovelPage> createState() => _LightNovelPageState();
}

class _LightNovelPageState extends State<LightNovelPage> {
  // DatabaseReference ref = FirebaseDatabase.instance.ref("novel");
  var ref = FirebaseDatabase.instance.reference().child('novel');

  var searchState = false;
  var searchQuery = "";

  void _toggleSearch() {
    setState(() {
      searchState = !searchState;
    });
  }

  void _searchQuery(String text) {
    setState(() {
      searchQuery = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 242, 255),
      appBar: AppBar(
        title: !searchState
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Icon(
                  Icons.book,
                  color: Colors.cyan,
                ),
                Text(
                  '  LightManga',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
              ])
            : TextField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.white)),
                onChanged: (text) {
                  _searchQuery(text);
                },
              ),
        backgroundColor: const Color.fromARGB(255, 204, 242, 255),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          !searchState
              ? IconButton(
                  onPressed: () {
                    _toggleSearch();
                    _searchQuery("");
                  },
                  icon: const Icon(Icons.search),
                )
              : IconButton(
                  onPressed: () {
                    _toggleSearch();
                    _searchQuery("");
                  },
                  icon: const Icon(Icons.cancel),
                ),
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
      body: SafeArea(
          child: FirebaseAnimatedList(
        shrinkWrap: true,
        query: ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map<dynamic, dynamic> values =
              snapshot.value as Map<dynamic, dynamic>;
          if (values['name']
              .toLowerCase()
              .contains(searchQuery.toLowerCase())) {
            return InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LightNovelDetail(lightnovel: values))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(values["name"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            values['img'],
                            width: 150,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  for (var i = 0; i < values['tag'].length; i++)
                                    Container(
                                        height: 30,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 204, 242, 255),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        margin: const EdgeInsets.all(3),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(values['tag'][i]),
                                        )),
                                ]),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          subtitle: Text(
                            values['synopsis'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox(
              height: 10,
            );
          }
        },
      )),
    );
  }
}
