import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:racket_match/models/room.dart';
import 'package:racket_match/services/room_service.dart';

class RoomSelectionViewModel with ChangeNotifier {
  bool _loading = false;
  bool _errorHasOccurred = false;
  String _errorMessage = '';

  void switchLoading() => _loading = !_loading;

  bool get isLoading => _loading;
  bool get errorHasOccurred => _errorHasOccurred;
  String get errorMessage => _errorMessage;

  setErrorMessage(String errorMessage){
    _errorMessage = errorMessage;
    _errorHasOccurred = true;
    notifyListeners();
  }

  clearErrorMessage(){
    _errorMessage = '';
    _errorHasOccurred = false;
    notifyListeners();
  }

  Future<Room> selectRoomByRoomID(int uniqueIdentifier) async {
    clearErrorMessage();

    try{
      var joinRoom = await RoomService.getRoomFromIdentifier(uniqueIdentifier);
      clearErrorMessage();
      return Room.fromJson(jsonDecode(joinRoom.body));
    }
    catch(e) {
      setErrorMessage(e.toString());
    }

    throw Exception("Could not find room");
  }

}