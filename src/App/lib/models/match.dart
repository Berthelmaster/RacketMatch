import 'package:racket_match/models/player.dart';

class Match{
  final int id;
  final List<Player> players;

  Match({
    required this.id,
    required this.players,
  });

  factory Match.fromJson(Map<String, dynamic> json){
    return Match(
      id: json["id"],
      players: json['players'],
    );
  }
}