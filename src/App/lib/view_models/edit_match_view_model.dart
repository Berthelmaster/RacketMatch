import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:racket_match/models/match.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/services/match_service.dart';
import 'package:racket_match/services/player_service.dart';

class EditMatchViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isChecked = false;
  late int _roomId;
  String _checkboxTitle = "Single";
  Match? _match;
  late final List<Player> _players = <Player>[];
  Player? _playerOne;
  Player? _playerTwo;
  Player? _playerThree;
  Player? _playerFour;
  bool _playerOneAdded = false;
  bool _playerTwoAdded = false;
  bool _playerThreeAdded = false;
  bool _playerFourAdded = false;
  final List<Player?> _teamOne = <Player>[];
  final List<Player?> _teamTwo = <Player>[];

  bool get isLoading => _isLoading;
  Match? get match => _match;
  bool get isChecked => _isChecked;
  String get checkboxTitle => _checkboxTitle;
  List<Player> get players => _players;
  List<Player?> get teamOne => _teamOne;
  List<Player?> get teamTwo => _teamTwo;

  EditMatchViewModel(Match? match, int roomId) {
    _match = match;
    _roomId = roomId;
  }

  void toggleIsChecked() {
    _isChecked = !_isChecked;
    _isChecked ? _checkboxTitle = "Double" : _checkboxTitle = "Single";
    if(_playerTwo != null) {
      _teamOne.remove(_playerTwo);
    }
    if(_playerFour != null) {
      _teamTwo.remove(_playerFour);
    }
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  Future<void> fetchPlayers() async {
    setLoading(true);

    try {
      var response = await PlayerService.fetchPlayers(_roomId);
      Iterable decoded = json.decode(response.body);
      List<Player> jsonPlayer =
          List<Player>.from(decoded.map((model) => Player.fromJson(model)));
      _players.addAll(jsonPlayer);
    } catch (e) {

    }

    notifyListeners();
    setLoading(false);
  }

  List<String> getPlayersByName() {
    List<String> names = [];

    for (var player in _players) {
      names.add(player.name);
    }
    return names;
  }

  Future<List<String>> filterByValue(String filter) async {
    Iterable<Player> filteredPlayers = _players.where(
        (element) => element.name.toLowerCase().contains(filter.toLowerCase()));
    List<String> result = [];
    for (var f in filteredPlayers) {
      result.add(f.name);
    }

    return result;
  }

  addedPlayerToMatch(String selected, int index) {
    var selectedPlayer =
        _players.firstWhere((element) => element.name == selected);

    switch (index) {
      case 0:
        {
          if(_playerOneAdded == true){
            _teamOne.remove(_playerOne);
          }
          _playerOne = selectedPlayer;
          _teamOne.add(_playerOne);
          _playerOneAdded = true;
        }
        break;

      case 1:
        {
          if(_playerTwoAdded == true){
            _teamOne.remove(_playerTwo);
          }

          _playerTwo = selectedPlayer;
          _teamOne.add(_playerTwo);
          _playerTwoAdded = true;
        }
        break;

      case 2:
        {
          if(_playerThreeAdded == true){
            _teamTwo.remove(_playerThree);
          }

          _playerThree = selectedPlayer;
          _teamTwo.add(_playerThree);
          _playerThreeAdded = true;
        }
        break;

      case 3:
        {
          if(_playerFourAdded == true){
            _teamTwo.remove(_playerFour);
          }

          _playerFour = selectedPlayer;
          _teamTwo.add(_playerFour);
          _playerFourAdded = true;
        }
        break;

      default:
        {
          throw Exception('player index out of range');
        }
    }

    notifyListeners();
  }

  Future<void> createOrEditMatch() async{
    if(_teamOne.isEmpty || _teamTwo.isEmpty){
      return;
    }

    var joinedPlayerList = List<Player?>.from(_teamOne)..addAll(_teamTwo);

    try {
      var response = await MatchService.createOrEditMatch(_roomId, _roomId.toString(), joinedPlayerList as List<Player>);
      print(response);
    } catch (e) {

    }







  }
}
