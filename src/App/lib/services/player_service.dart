import 'dart:convert';

import 'package:racket_match/constants.dart';
import 'package:http/http.dart' as http;
import 'package:racket_match/models/player.dart';

class PlayerService{

  static Future<http.Response> createPlayer(int roomId, Player player) async{
    var url = Uri.parse("$httpBaseEndpoint/player?roomId=$roomId");

    var response = await http.post(url, body: json.encode(player.toJson()), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    })
        .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Failed to communicate with server');
        });

    if(response.statusCode == 200){
      return response;
    }

    throw('Could Not add player');

  }

  static Future<http.Response> fetchPlayers(int roomId) async{
    var url = Uri.parse("$httpBaseEndpoint/player?roomId=$roomId");

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    })
        .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Failed to communicate with server');
        });

    if(response.statusCode == 200){
      return response;
    }

    throw('Could Not add player');

  }
}