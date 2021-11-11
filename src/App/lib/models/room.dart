import 'dart:convert';

class Room{
  final int id;
  final String roomName;

  Room({
    required this.id,
    required this.roomName
  });

  factory Room.fromJson(Map<String, dynamic> json){
    return Room(
    id: json["id"],
    roomName: json['roomName'],
    );
  }

}