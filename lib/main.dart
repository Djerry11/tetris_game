import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetris_game/home_screen.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tetris',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.vt323TextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // home: const Scaffold(
      //   body: TetrisBoard(),
      // ),
      home: HomeScreen(),
    );
  }
}
