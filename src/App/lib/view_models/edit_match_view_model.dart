import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:racket_match/models/match.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/services/player_service.dart';

class EditMatchViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool _isChecked = false;
  String _checkboxTitle = "Single";
  Match? _match;
  late List<Player> _players = <Player>[];

  bool get isLoading => _isLoading;
  Match? get match => _match;
  bool get isChecked => _isChecked;
  String get checkboxTitle => _checkboxTitle;
  List<Player> get players => _players;

  void toggleIsChecked(){
    _isChecked = !_isChecked;
    _isChecked ? _checkboxTitle = "Double" : _checkboxTitle = "Single";
    notifyListeners();
  }

  EditMatchViewModel(Match? match){
    _match = match;
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

}