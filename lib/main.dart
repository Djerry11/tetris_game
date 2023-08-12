import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        fontFamily: 'DSEG14',
      ),
      // home: const Scaffold(
      //   body: TetrisBoard(),
      // ),
      home: HomeScreen(),
    );
  }
}
