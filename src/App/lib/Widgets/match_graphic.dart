import 'package:flutter/cupertino.dart';
import 'package:racket_match/models/player.dart';

class MatchGraphic extends StatelessWidget{

  final List<Player> teamOne;
  final List<Player> teamTwo;

  MatchGraphic({required this.teamOne, required this.teamTwo});

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>
      [
        Container(
          color: Color(0x70000000),
          alignment: Alignment.center,
          child: Image(
            image: const AssetImage('lib/assets/images/istockphoto-829923188-612x612.jpg'),
            width: we*0.45,
            height: he*0.50,
          ),
        ),
          // Player 1
          Container(
            alignment: Alignment.center,
            width: (we*0.45) / 2,
            height: he * 0.25,
            color: Color(0x70000000),
            child: Text(teamOne[0].name,
              textAlign: TextAlign.center,
            ),
          ),
          // Player 2
          Container(
            alignment: Alignment.center,
            width: (we*0.45) / 2,
            height: he * 0.25,
            color: Color(0x70000000),
            margin: EdgeInsets.only(left: (we*0.45) / 2),
            child: Text(teamOne[1].name,
              textAlign: TextAlign.center,
            ),
          ),
          // Player 3
          Container(
            alignment: Alignment.center,
            width: (we*0.45) / 2,
            height: he * 0.25,
            color: Color(0x70000000),
            margin: EdgeInsets.only(top: he * 0.25),
            child: Text(teamTwo[0].name,
              textAlign: TextAlign.center,
            ),
          ),
          // Player 4
          Container(
            alignment: Alignment.center,
            width: (we*0.45) / 2,
            height: he * 0.25,
            color: Color(0x70000000),
            margin: EdgeInsets.only(top: he * 0.25, left: (we*0.45) / 2),
            child: Text(teamTwo[1].name,
              textAlign: TextAlign.center,
            ),
          ),
          // VS
          Container(
            alignment: Alignment.center,
            width: (we*0.45) / 2,
            height: he * 0.25,
            color: Color(0x70000000),
            margin: EdgeInsets.only(top: he * 0.125, left: (we*0.225) / 2),
            child: const Text('VS',
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}