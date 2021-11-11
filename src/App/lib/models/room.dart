import 'dart:convert';

class Room{
  final int id;
  final String roomName;
  final int uniqueRoomIdentifier;

  Room({
    required this.id,
    required this.roomName,
    required this.uniqueRoomIdentifier,
  });

  factory Room.fromJson(Map<String, dynamic> json){
    return Room(
    id: json["id"],
    roomName: json['roomName'],
    uniqueRoomIdentifier: json['uniqueRoomIdentifier'],
    );
  }

}