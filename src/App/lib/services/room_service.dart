import 'package:racket_match/constants.dart';
import 'package:http/http.dart' as http;

class RoomService{

  static Future<http.Response> createRoom(String roomName) async {
    var url = Uri.parse("$httpBaseEndpoint/room?roomName=$roomName");

    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    })
    .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Failed to communicate with server');
        });

    print(response.body);

    if(response.statusCode == 200) {
      return response;
    }

    throw Exception('Room "$roomName" already exists');
  }

  static Future<http.Response> getRoomFromIdentifier(int uniqueIdentifier) async {
    var url = Uri.parse("$httpBaseEndpoint/room?uniqueIdentifier=$uniqueIdentifier");

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    })
        .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Failed to communicate with server');
        });

    if(response.statusCode == 200) {
      return response;
    }

    throw Exception('Failed to find room with ID: $uniqueIdentifier');
  }
}