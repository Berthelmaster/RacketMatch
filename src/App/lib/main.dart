import 'package:flutter/material.dart';
import 'package:racket_match/screens/court.dart';
import 'package:racket_match/screens/create_room.dart';
import 'package:racket_match/screens/selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        /*
          List of routes and what they do
        */

        // Find or Create Room
        '/': (context) => Selector(),
        // Shows the room and valid courts
        '/court': (context) => Court(),
        // Create a room
        '/create': (context) => CreateRoom()
      },
    );
  }
}