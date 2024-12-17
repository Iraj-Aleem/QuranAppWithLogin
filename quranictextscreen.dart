import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'bookmarkingscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QuranicTextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 148, 180, 5),
          title: Text(
            'Al-Quran App\nQuranic Text',
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookmarkScreen()),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: quran.totalSurahCount,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Surah(index+1)),
                );
              },
              title: Text(quran.getSurahNameArabic(index + 1)),
              subtitle: Text(quran.getSurahNameEnglish(index + 1)),
              leading: CircleAvatar(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.amber[900],
              ),
              trailing: Text('${quran.getVerseCount(index + 1)}'),
            );
          },
        ),
      ),
    );
  }
}

class Surah extends StatefulWidget {
  final int indexSurah;

  Surah(this.indexSurah, {Key? key}) : super(key: key);

  @override
  _SurahState createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  List<int> bookmarkedVerses = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  _loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarkedVerses = (prefs.getStringList('bookmarks_${widget.indexSurah}') ?? [])
          .map((e) => int.parse(e))
          .toList();
    });
  }

  _toggleBookmark(int verseIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (bookmarkedVerses.contains(verseIndex)) {
        bookmarkedVerses.remove(verseIndex);
      } else {
        bookmarkedVerses.add(verseIndex);
      }
    });
    await prefs.setStringList(
      'bookmarks_${widget.indexSurah}',
      bookmarkedVerses.map((e) => e.toString()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 148, 180, 5),
        title: Text(
          quran.getSurahNameEnglish(widget.indexSurah ),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView.builder(
        itemCount: quran.getVerseCount(widget.indexSurah),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              quran.getVerse(
                widget.indexSurah + 1,
                index + 1,
                verseEndSymbol: true,
              ),
              textAlign: TextAlign.right,
            ),
            trailing: IconButton(
              icon: Icon(
                bookmarkedVerses.contains(index + 1)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () {
                _toggleBookmark(index + 1);
              },
            ),
          );
        },
      ),
    );
  }
}