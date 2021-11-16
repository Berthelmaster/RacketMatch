import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/models/player.dart';

class MatchGraphic extends StatelessWidget{

  final List<Player> teamOne;
  final List<Player> teamTwo;
  final bool isInFocus;
  final int id;
  final Function(int id) onDelete;
  final Function(int id) onEdit;

  MatchGraphic({required this.id, required this.teamOne, required this.teamTwo, required this.isInFocus, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;
    print('Is in focus?: $isInFocus');

    // Add the two lists together, if there are 3 or more players it must be a double match
    var isDoubles = (List.from(teamOne)..addAll(teamTwo)).length >= 3 ? true : false;

    return isInFocus ?
      FadeAnimation(
        delay: 0.25,
        child: Center(
          child: Container(
            height: he*0.20,
            width: we*0.45,
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue
                  ),
                  onPressed: () => {
                    onEdit(id)
                  },
                  child: Text('  Edit match  '),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onSurface: Colors.red,
                  ),
                  onPressed: () => {
                    onDelete(id)

                  },
                  child: Text('Delete match'),
                )
              ],
            ),
          ),
        ),
      )
        : Stack(
      children: <Widget>
      [
        FadeAnimation(
          delay: 0.25,
          child: Image(
            image: const AssetImage('lib/assets/images/istockphoto-829923188-612x612.jpg'),
            width: we*0.45,
            height: he*0.50,
            fit: BoxFit.fill,
          ),
        ),
          isDoubles == true ?
          // Player 1
          FadeAnimation(
            delay: 0.25,
            child: Stack(
              children: <Widget> [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          //color: Color(0x70000000),
                          alignment: Alignment.center,
                          width: (we*0.45) / 2,
                          height: he * 0.225,
                          child: Text(teamOne[0].name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Player 2
                        Container(
                          //color: Color(0x70000000),
                          alignment: Alignment.center,
                          width: (we*0.45) / 2,
                          height: he * 0.225,
                          //margin: EdgeInsets.only(bottom: 20),
                          child: Text(teamOne[1].name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // Player 3
                    Row(

                      children: [
                        Container(
                          //color: Color(0x70000000),
                          alignment: Alignment.center,
                          width: (we*0.45) / 2,
                          height: he * 0.25,
                          //margin: EdgeInsets.only(top: he * 0.25),
                          child: Text(teamTwo[0].name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Player 4
                        Container(
                          //color: Color(0x70000000),
                          alignment: Alignment.center,
                          width: (we*0.45) / 2,
                          height: he * 0.25,
                          //margin: EdgeInsets.only(top: he * 0.25, left: (we*0.45) / 2),
                          child: Text(teamTwo[1].name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(

                  alignment: Alignment.center,
                  width: (we*0.45) / 2,
                  height: he * 0.225,
                  margin: EdgeInsets.only(top: he * 0.125, left: (we*0.225) / 2),
                  child: Text('VS',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.heebo(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: 16,
                      )
                  ),
                ),
              ]
            ),
          )

          :
          FadeAnimation(
            delay: 0.25,
            child: Stack(
                children: <Widget> [
                  Column(
                    children: [
                      Container(
                        //color: Color(0x70000000),
                        alignment: Alignment.center,
                        width: (we*0.45) / 2,
                        height: he * 0.225,
                        margin: EdgeInsets.only(left: (we*0.225) / 2),
                        child: Text(teamOne[0].name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Player 3
                      Container(
                        //color: Color(0x70000000),
                        alignment: Alignment.center,
                        width: (we*0.45) / 2,
                        height: he * 0.25,
                        margin: EdgeInsets.only(left: (we*0.225) / 2),
                        child: Text(teamTwo[0].name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: (we*0.45) / 2,
                    height: he * 0.225,
                    margin: EdgeInsets.only(top: he * 0.125, left: (we*0.225) / 2),
                    child: Text('VS',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 16,
                        )
                    ),
                  ),
                ]
            ),
          )

      ],
    );
  }
}