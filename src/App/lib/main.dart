import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racket_match/screens/court.dart';
import 'package:racket_match/screens/create_room.dart';
import 'package:racket_match/screens/selector.dart';
import 'package:racket_match/view_models/create_room_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => CreateRoomViewModel(),
      )
    ],
    child: MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        /*
          List of routes and what they do
        */

        // Find or Create Room
        '/': (context) => Main(),
        // Shows the room and valid courts
        '/court': (context) => Court(),
        // Create a room
        '/create': (context) => CreateRoom()
      },
    ));
  }
}