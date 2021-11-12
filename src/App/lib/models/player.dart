class Player{
  final int id;
  final String name;
  final team;

  Player({
    required this.id,
    required this.name,
    required this.team,
  });

  factory Player.fromJson(Map<String, dynamic> json){
    return Player(
      id: json['id'],
      name: json['name'],
      team: json['team'],
    );
  }

}


enum Team{
  team1,
  team2
}