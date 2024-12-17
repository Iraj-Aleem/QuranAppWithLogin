import 'package:flutter/material.dart';

import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart'; // Add this for persistence
class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  Map<int, List<int>> bookmarks = {};

  @override
  void initState() {
    super.initState();
    _loadAllBookmarks();
  }

  _loadAllBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<int, List<int>> loadedBookmarks = {};
    for (int surahIndex = 1; surahIndex <= quran.totalSurahCount; surahIndex++) {
      List<String>? storedBookmarks = prefs.getStringList('bookmarks_$surahIndex');
      if (storedBookmarks != null) {
        loadedBookmarks[surahIndex] = storedBookmarks.map((e) => int.parse(e)).toList();
      }
    }
    setState(() {
      bookmarks = loadedBookmarks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 148, 180, 5),
        title: Text(
          'Bookmarked Verses',
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, surahIndex) {
          int surah = bookmarks.keys.elementAt(surahIndex);
          return ExpansionTile(
            title: Text(quran.getSurahNameEnglish(surah)),
            children: bookmarks[surah]!.map((verse) {
              return ListTile(
                title: Text(
                  quran.getVerse(surah, verse, verseEndSymbol: true),
                  textAlign: TextAlign.right,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


