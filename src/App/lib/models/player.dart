import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player{
  final int id;
  final String name;
  final team;

  Player({
    required this.id,
    required this.name,
    this.team,
  });

  // To send to server
  Player.dto(this.id, this.team, {
    required this.name
  });

  factory Player.fromJson(Map<String, dynamic> json){
    return Player(
      id: json['id'],
      name: json['name'],
      team: json['team'],
    );
  }

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

}


enum Team{
  team1,
  team2
}