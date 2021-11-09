import 'dart:io';

import 'package:flutter/material.dart';
import 'package:racket_match/services/room_service.dart';

class RoomSelectionViewModel with ChangeNotifier {
  bool _loading = false;

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