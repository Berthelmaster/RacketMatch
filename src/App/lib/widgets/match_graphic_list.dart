import 'package:flutter/material.dart';
import 'package:racket_match/models/match.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/widgets/match_graphic.dart';

class MatchGraphicList extends StatelessWidget{

  final List<Match> matches;
  final Function(int index) onLongPressCallback;
  final Function(int id) onDeleteCallback;

  MatchGraphicList({required this.matches, required this.onLongPressCallback, required this.onDeleteCallback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: matches.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height),
            mainAxisSpacing: 8
        ),
        itemBuilder: (context, index) =>
            GestureDetector(
              onLongPress: () => onLongPressCallback(index),
                child: MatchGraphic(
                    id: matches[index].id,
                    teamOne: matches[index].players.where((x) => x.team == Team.team1).toList(),
                    teamTwo: matches[index].players.where((x) => x.team == Team.team2).toList(),
                    isInFocus: matches[index].isInFocus,
                    onDelete: onDeleteCallback
                )
            ),
      )

    );

  }
}