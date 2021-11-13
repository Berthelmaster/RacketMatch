import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:racket_match/Widgets/match_graphic.dart';
import 'package:racket_match/models/match.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/models/room.dart';
import 'package:racket_match/view_models/room_instance_view_model.dart';
import 'package:racket_match/widgets/match_graphic_list.dart';

//ignore: must_be_immutable
class RoomInstance extends StatefulWidget{
  RoomInstance.optional({Key? key}) : super(key: key);
  RoomInstance({Key? key, required this.room}) : super(key: key);

  late Room room;


  @override
  State<RoomInstance> createState() => _RoomInstanceState();
}

class _RoomInstanceState extends State<RoomInstance> {

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    Player player1 = Player(id: 1, name: 'PLayer_1', team: Team.team1);
    Player player2 = Player(id: 2, name: 'PLayer_2', team: Team.team1);
    Player player3 = Player(id: 3, name: 'PLayer_3', team: Team.team2);
    Player player4 = Player(id: 4, name: 'PLayer_4', team: Team.team2);
    Player player5 = Player(id: 5, name: 'PLayer_5', team: Team.team1);
    Player player6 = Player(id: 6, name: 'PLayer_6', team: Team.team2);


    var team1 = [player1, player2];
    var team2 = [player3, player4];
    var team3 = [player5];
    var team4 = [player6];

    Match match1 = Match(id: 1, players: [player1, player2, player3, player4]);
    Match match2 = Match(id: 2, players: [player5, player6]);
    Match match3 = Match(id: 3, players: [player5, player6]);
    Match match4 = Match(id: 4, players: [player5, player6]);
    Match match5 = Match(id: 5, players: [player5, player6]);
    Match match6 = Match(id: 6, players: [player5, player6]);
    Match match7 = Match(id: 7, players: [player5, player6]);
    var matches = [match1, match2];

    var roomInstanceViewModel = Provider.of<RoomInstanceViewModel>(context);
    // title: Text(widget.room.roomName),
    return Scaffold(
      backgroundColor: const Color(0xFF1F1A30),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: he * 0.04,
            ),
            Center(
              child: Text('Room ID: ${widget.room.uniqueRoomIdentifier.toString()}',
                style: GoogleFonts.heebo(
                  color:  const Color(0xFF9746A0).withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,)),
            ),
            MatchGraphicList(matches: roomInstanceViewModel.matches),
            ElevatedButton(
              onPressed: (){
                roomInstanceViewModel.updateMatch(match1);
              },
              child: const Text('123'),
            )

          ],
        ),
      )

    );
  }
}