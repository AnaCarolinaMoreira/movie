import 'package:flutter/material.dart';
import 'package:movie/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//AnaCarolinaMoreira
  //Kenobi12#
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: const HomeScreen(),
    );
  }
}
