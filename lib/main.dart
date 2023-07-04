import 'package:flutter/material.dart';
import 'package:world_time_app/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      // initialRoute: '/home',
      // routes: {
      //   '/home': (context) => const Home(),
      //   // '/location': (context) => const Location(),
      // },
    );
  }
}
