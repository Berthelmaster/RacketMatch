import 'dart:convert';

import 'package:racket_match/constants.dart';
import 'package:http/http.dart' as http;
import 'package:racket_match/models/player.dart';

class MatchService{

  static Future<http.Response> createOrEditMatch(int roomId, String groupName, List<Player> players) async{
    var url = Uri.parse("$httpBaseEndpoint/player?roomId=$roomId&groupName=$groupName");

    var response = await http.post(url, body: json.encode(players), headers: <String, String>{
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