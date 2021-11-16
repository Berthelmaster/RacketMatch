import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:racket_match/services/hub_clients/on_connection_join.dart';
import 'package:racket_match/services/room_service.dart';
import 'package:racket_match/models/match.dart';

class RoomInstanceViewModel with ChangeNotifier {

  bool _loading = false;
  List<Match> _matches = [];
  OnConnectionJoin? _onConnectionJoinHub;

  RoomInstanceViewModel(){
    _loading = false;
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



  void switchLoading() => _loading = !_loading;


  Future<void> onLongPressOnMatch(int index) async{
    print(index);
    for (var match in _matches) {
      if(match.isInFocus) {
        if(_matches[index] == match) continue;
        match.isInFocus = false;
      }
    }
    _matches[index].isInFocus = !(_matches[index].isInFocus);
    notifyListeners();
  }

  Future<void> onDeletedMatch(int id) async {
    var match = _matches.firstWhere((x) => x.id == id);
    _matches.remove(match);
    print('_matches length: ${_matches.length}');
    notifyListeners();
  }
}