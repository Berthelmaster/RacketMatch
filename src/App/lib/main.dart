import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:racket_match/screens/add_players.dart';
import 'package:racket_match/screens/edit_match.dart';
import 'package:racket_match/screens/room_instance.dart';
import 'package:racket_match/screens/create_room.dart';
import 'package:racket_match/screens/room_selector.dart';
import 'package:racket_match/view_models/create_room_view_model.dart';
import 'package:racket_match/view_models/room_instance_view_model.dart';
import 'package:racket_match/view_models/room_selection_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
        '/': (context) => RoomSelector(),
        // Shows the room and valid courts
        '/room': (context) => RoomInstance(),
        // Create a room
        '/create': (context) => CreateRoom(),
        // Edit match on a specific room
        '/edit': (context) => EditMatch(),
        // Add Players
        '/add': (context) => AddPlayers()
      },
    );
  }
}