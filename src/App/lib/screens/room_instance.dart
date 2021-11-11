import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racket_match/Widgets/match_graphic.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/models/room.dart';

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

    Player player1 = Player(1, 'PLayer_1', Team.Team1);
    Player player2 = Player(2, 'PLayer_2', Team.Team1);
    Player player3 = Player(3, 'PLayer_3', Team.Team2);
    Player player4 = Player(4, 'PLayer_4', Team.Team2);

    var team1 = [player1, player2];
    var team2 = [player3, player4];

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
            Container(
              alignment: Alignment.center,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MatchGraphic(
                      teamOne: team1,
                      teamTwo: team2,
                    ),
                    SizedBox(
                      width: we * 0.01,
                    ),
                    MatchGraphic(
                      teamOne: team1,
                      teamTwo: team2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}