import 'package:all_in_one/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All-In-One',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
