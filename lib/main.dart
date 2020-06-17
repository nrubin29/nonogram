import 'package:flutter/material.dart';
import 'package:nonogram/views/puzzle_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nonogram',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home:
          Scaffold(appBar: AppBar(title: Text('Nonogram')), body: PuzzleView()),
    );
  }
}
