import 'package:flutter/material.dart';

class CreateRoomViewModel extends ChangeNotifier{
  bool _loading = false;
  String _roomName = '';

  setLoading(bool loading) async {

  }

  createRoom(String roomName){
    print(roomName + "DD");
  }
}