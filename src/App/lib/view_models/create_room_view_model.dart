import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:racket_match/models/room.dart';
import 'package:racket_match/services/room_service.dart';

class CreateRoomViewModel extends ChangeNotifier{
  bool _loading = false;
  bool _errorHasOccurred = false;
  String _errorMessage = '';

  void switchLoading(){
    _loading = !_loading;
    notifyListeners();
  }

  bool get isLoading => _loading;

  bool get errorHasOccurred => _errorHasOccurred;
  String get errorMessage => _errorMessage;


  setLoading(bool loading) async {

  }

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

  Future<Room> createRoom(String roomName) async{
    if(_errorHasOccurred){
      clearErrorMessage();
    }

    try{
      var createRoom = await RoomService.createRoom(roomName);
      return Room.fromJson(jsonDecode(createRoom.body));
    }
    catch(e) {
      setErrorMessage(e.toString());
    }

    throw Exception('Create Room Exception');
  }
}