import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:racket_match/models/match.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/services/player_service.dart';

class EditMatchViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool _isChecked = false;
  late int _roomId;
  String _checkboxTitle = "Single";
  Match? _match;
  late List<Player> _players = <Player>[];
  late List<Player> _takenPlayers = <Player>[];

  bool get isLoading => _isLoading;
  Match? get match => _match;
  bool get isChecked => _isChecked;
  String get checkboxTitle => _checkboxTitle;
  List<Player> get players => _players;
  List<String> get player_names => getPlayersByName();

  void toggleIsChecked(){
    _isChecked = !_isChecked;
    _isChecked ? _checkboxTitle = "Double" : _checkboxTitle = "Single";
    notifyListeners();
  }

  void addToTakenPlayerByName(String name, int occupiedSlot){
    var takenPlayer = _players.firstWhere((element) => element.name == name);
    _takenPlayers.add(takenPlayer);
  }

  EditMatchViewModel(Match? match, int roomId){
    _match = match;
    _roomId = roomId;
  }

  void setLoading(bool isLoading){
    _isLoading = isLoading;
  }

  Future<void> fetchPlayers() async {
    setLoading(true);

    try{
      var response = await PlayerService.fetchPlayers(_roomId);
      Iterable decoded = json.decode(response.body);
      List<Player> jsonPlayer = List<Player>.from(decoded.map((model) => Player.fromJson(model)));
      _players.addAll(jsonPlayer);
    }
    catch(e){

    }

    notifyListeners();
    setLoading(false);
  }

  List<String> getPlayersByName(){
    List<String> names = [];

    for(var player in _players){
      if(_takenPlayers.contains(player)) continue;
      names.add(player.name);
    }
    return names;
  }

  Future<List<String>> filterByValue(String filter) async{
    Iterable<Player> filteredPlayers = _players.where((element) => element.name.toLowerCase().contains(filter.toLowerCase()));
    List<String> result = [];
    for(var f in filteredPlayers){
      result.add(f.name);
    }

    return result;
  }



}