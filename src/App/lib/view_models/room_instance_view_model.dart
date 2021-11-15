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
  OnConnectionJoin? _onConnectionJoinHub;

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

  Future<void> setupHubConnection(String roomId) async {
    print("Matches: ${_matches.length}");
    print("Loading?: $_loading");
    _loading = true;
    _onConnectionJoinHub = await OnConnectionJoin(roomId, onNewConnection).initialize();
    notifyListeners();
  }

  Future<void> disposeHubConnection() async {
    _onConnectionJoinHub!.dispose();
  }

  void onNewConnection(List<Object>? object){
    var response = object![0].toString();

    Fluttertoast.showToast(
        msg: response,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 10.0
    );
  }

  Future<void> onLongPressOnMatch(int index) async{
    print(index);
  }


  void switchLoading() => _loading = !_loading;

  void clearViewModel(){
    _loading = false;
    _roomId = null;
    _matches = [];
  }



}