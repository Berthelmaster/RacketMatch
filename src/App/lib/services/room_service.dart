import 'package:flutter/material.dart';
import 'package:racket_match/constants.dart';
import 'package:http/http.dart' as http;

class RoomService{

  static Future<http.Response> createRoom(String roomName) async {
    var url = Uri.parse("$HttpBaseEndpoint/room?roomName=$roomName");

    print(url);

    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if(response.statusCode == 200) {
      return response;
    }

    throw Exception('Room "$roomName" already exists');
  }

  static Future<http.Response> getRoomFromIdentifier(String roomId) async {
    var url = Uri.parse("$HttpBaseEndpoint/room?roomId=$roomId");

    var response = await http.get(url);

    if(response.statusCode == 200) {
      return response;
    }

    throw Exception('Failed to get Room');
  }
}