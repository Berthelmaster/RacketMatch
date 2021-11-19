import 'package:flutter/cupertino.dart';
import 'package:racket_match/models/player.dart';

class AddPlayersViewModel extends ChangeNotifier{
  bool _loading = false;
  final List<Player> _players = <Player>[];

  bool get isLoading => _loading;
  List<Player> get players => _players;

  void setLoading(bool loading){
    _loading = loading;
  }

  Future<void> addPlayer(Player player) async{
    _players.add(player);
    notifyListeners();
  }

  Future<void> onDelete(int id) async{
    setLoading(true);

    print(id);

    setLoading(false);
  }
}