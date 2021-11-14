import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:racket_match/services/hub_clients/on_connection_join.dart';
import 'package:racket_match/services/room_service.dart';
import 'package:racket_match/models/match.dart';

class RoomInstanceViewModel with ChangeNotifier {

  bool _loading = false;
  String? _roomId;
  List<Match> _matches = [];
  var _onConnectionJoinHub;

  RoomInstanceViewModel(){
    print('CAAALEED');
    _loading = false;
    _roomId = null;
    _matches = [];
  }


  bool get isLoading => _loading;
  List<Match> get matches => _matches;

  void updateMatch(Match match){
    _matches.add(match);
    print(_matches.length);
    notifyListeners();
  }

  void setupHubConnection(String roomId) async {
    print("Matches: ${_matches.length}");
    print("Loading?: $_loading");
    _loading = true;
    _onConnectionJoinHub = await OnConnectionJoin(roomId, onNewConnection).initialize();
    notifyListeners();
  }

  void onNewConnection(List<Object>? object){
    var aa = object.toString();
    print('New Connection!! $aa');
  }


  void switchLoading() => _loading = !_loading;


  Future<String> selectRoomByRoomID(String roomID) async {
    print(roomID);
    var request = await RoomService.getRoomFromIdentifier(roomID);

    if(request.statusCode == 200){
      return request.body;
    }

    throw Exception("Could not find room");
  }

  void clearViewModel(){
    _loading = false;
    _roomId = null;
    _matches = [];
  }



}