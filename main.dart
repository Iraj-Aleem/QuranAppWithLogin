import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranepak/firebase_options.dart';
import 'auth_provider.dart';
import 'homescreen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            return auth.currentUser != null ?  HomeScreen() :  LoginScreen();
          },
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart' as GoogleFonts;
// import 'package:quran/quran.dart' as quran;
// import 'package:quranepak/homescreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:quranepak/login_screen.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(MaterialApp(
//     home: LoginScreen(), // Set HomeScreen as the home widget
//   ));
// }
// // ...


// class QuranExample extends StatefulWidget {
//   const QuranExample({super.key});

//   @override
//   State<QuranExample> createState() => _QuranExampleState();
// }

// class _QuranExampleState extends State<QuranExample> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Quran Demo"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Juz Number: \n${quran.getJuzNumber(18, 1)}"),
//               Text("\nJuz URL: \n${quran.getJuzURL(15)}"),
//               Text(
//                   "\nSurah and Verses in Juz 15: \n${quran.getSurahAndVersesFromJuz(15)}"),
//               Text("\nSurah Name: \n${quran.getSurahName(18)}"),
//               Text(
//                   "\nSurah Name (English): \n${quran.getSurahNameEnglish(18)}"),
//               Text("\nSurah URL: \n${quran.getSurahURL(18)}"),
//               Text("\nTotal Verses: \n${quran.getVerseCount(18)}"),
//               Text(
//                   "\nPlace of Revelation: \n${quran.getPlaceOfRevelation(18)}"),
//               Text("\nBasmala: \n${quran.basmala}",
//                  // style: GoogleFonts.amiriQuran()
//                   ),
//               Text(
//                 "\nVerse 1: \n${quran.getVerse(18, 1)}",
//                 //style: GoogleFonts.amiriQuran(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }