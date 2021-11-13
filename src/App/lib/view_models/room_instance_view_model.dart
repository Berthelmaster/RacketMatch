import 'dart:io';

import 'package:flutter/material.dart';
import 'package:racket_match/services/room_service.dart';
import 'package:racket_match/models/match.dart';

class RoomInstanceViewModel with ChangeNotifier {
  bool _loading = false;


  var _matches = <Match>[];

  void updateMatch(Match match){
    _matches.add(match);
    print(_matches.length);
    notifyListeners();
  }

  List<Match> get matches => _matches;

  void switchLoading() => _loading = !_loading;

  bool get isLoading => _loading;

  Future<String> selectRoomByRoomID(String roomID) async {
    print(roomID);
    var request = await RoomService.getRoomFromIdentifier(roomID);

    if(request.statusCode == 200){
      return request.body;
    }

    throw Exception("Could not find room");
  }

}