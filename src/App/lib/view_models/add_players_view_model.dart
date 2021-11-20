import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/services/player_service.dart';

class AddPlayersViewModel extends ChangeNotifier{
  bool _loading = false;
  final List<Player> _players = <Player>[];
  late int _roomId;

  AddPlayersViewModel(int roomId){
    _roomId = roomId;
  }

  bool get isLoading => _loading;
  List<Player> get players => _players;

  void setLoading(bool loading){
    _loading = loading;
    notifyListeners();
  }

  void showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 10.0
    );
  }

  Future<bool> addPlayer(String name) async{
    setLoading(true);
    // Create player from api
    Player player = Player.dto(0,null,name: name);

    try
    {
      var response = await PlayerService.createPlayer(_roomId, player);
      var jsonPlayer = Player.fromJson(jsonDecode(response.body));
      _players.insert(0, jsonPlayer);
      notifyListeners();
      setLoading(false);
      return true;
    }
    catch (e){
      showToast(e.toString());
    }

    notifyListeners();
    setLoading(false);
    return false;
  }

  Future<void> fetchPlayers() async {
    setLoading(true);

    try{
      var response = await PlayerService.fetchPlayers(_roomId);
      Iterable decoded = json.decode(response.body);
      List<Player> jsonPlayer = List<Player>.from(decoded.map((model) => Player.fromJson(model)));
      var reversed = jsonPlayer.reversed;
      _players.addAll(reversed);
    }
    catch(e){
      showToast(e.toString());
    }

    notifyListeners();
    setLoading(false);
  }

  Future<void> onDelete(int id) async{
    setLoading(true);
    var selected = _players.firstWhere((element) => element.id == id);
    _players.remove(selected);
    notifyListeners();
    setLoading(false);
  }
}