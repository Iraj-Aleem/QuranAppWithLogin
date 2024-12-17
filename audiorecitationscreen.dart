import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;

class AudioRecitationScreen extends StatefulWidget {
  const AudioRecitationScreen({super.key});

  @override
  State<AudioRecitationScreen> createState() => _AudioRecitationScreenState();
}

class _AudioRecitationScreenState extends State<AudioRecitationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 148, 180, 5),
          title: Text(
            'Al-Quran\nAudio Recitation',
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView.builder(
          itemCount:
              quran.totalSurahCount, // Ensure you set the total number of items
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Surah(index),
                    ));
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
  int indexsurah;
  Surah(this.indexsurah, {super.key});
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  @override
  AudioPlayer audioplayer = AudioPlayer();
  IconData playpauseButton = Icons.play_circle_fill_outlined;
  bool isplaying = false;

  Future<void> togglebutton() async {
    try {
      final audiourl = await quran.getAudioURLBySurah(widget.indexsurah + 1);
      audioplayer.setUrl(audiourl);
      print(audiourl);
      if (isplaying) {
        audioplayer.play();

        setState(() {
          playpauseButton = Icons.pause_circle_filled_rounded;
          isplaying = false;
        });
      } else {
        audioplayer.pause();
        audioplayer.pause();

        setState(() {
          playpauseButton = Icons.play_circle_filled_rounded;
          isplaying = true;
        });
      }
    } catch (e) {
      print("my error=>${e}");
    }
  }

  int? currentVerseIndex;

  Future<void> playVerse(int surahNumber, int verseNumber) async {
    try {
      final audiourl = await quran.getAudioURLByVerse(surahNumber, verseNumber);
      await audioplayer.setUrl(audiourl);
      audioplayer.play();
      setState(() {
        playpauseButton = Icons.pause_circle_filled_rounded;
        isplaying = true;
        currentVerseIndex = verseNumber;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void stopPlayback() {
    audioplayer.stop();
    setState(() {
      playpauseButton = Icons.play_circle_fill_outlined;
      isplaying = false;
      currentVerseIndex = null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioplayer.dispose();
    super.dispose();
  }

  // String getVerseWithEndSymbol(int surahNumber, int verseNumber,
  //     {bool arabicNumeral = true}) {
  //   String verse = quran.getVerse(surahNumber, verseNumber);
  //   String verseEndSymbol =
  //       quran.getVerseEndSymbol(verseNumber, arabicNumeral: arabicNumeral);
  //   return '$verse $verseEndSymbol'; // Combines the verse text with the end symbol.
  // }

  String getVerseWithEndSymbol(int surahNumber, int verseNumber,
      {bool arabicNumeral = true}) {
    String verse = quran.getVerse(surahNumber, verseNumber);
    String verseEndSymbol =
        quran.getVerseEndSymbol(verseNumber, arabicNumeral: arabicNumeral);
    return '$verse $verseEndSymbol'; // Combines the verse text with the end symbol.
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: quran.getVerseCount(widget.indexsurah + 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      getVerseWithEndSymbol(widget.indexsurah + 1, index + 1),
                      textAlign: TextAlign.right,
                      // quran.getVerse(
                      //   widget.indexsurah + 1,
                      //   index + 1,
                      //   verseEndSymbol: true,
                      // ),
                      //                     textAlign: TextAlign.right,
                      //  Use getVerseWithEndSymbol here to display the verse along with the end symbol
                      //                   getVerseWithEndSymbol(widget.indexsurah + 1, index + 1),
                      //                   textAlign: TextAlign.right,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        currentVerseIndex == index + 1
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_fill_outlined,
                        color: Colors.brown[900],
                      ),
                      onPressed: () {
                        if (currentVerseIndex == index + 1 && isplaying) {
                          stopPlayback();
                        } else {
                          playVerse(widget.indexsurah + 1, index + 1);
                        }
                      },
                    ),
                  );
                }),
          ),
          Card(
              elevation: 6,
              shadowColor: Colors.brown[900],
              child: Center(
                child: IconButton(
                    icon: Icon(
                      playpauseButton,
                      color: Colors.brown[900],
                    ),
                    onPressed: togglebutton),
              )),
        ],
      )),
    );
  }
}