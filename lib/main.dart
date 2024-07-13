import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   title:'Animated Tesla Car Control App' ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor:  Colors.black),
      home: homeScreen(),
    );
  }
}
