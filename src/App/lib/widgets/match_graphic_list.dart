import 'package:flutter/material.dart';
import 'package:racket_match/models/match.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchGraphicList extends StatelessWidget{

  final List<Match> matches;

  MatchGraphicList({required this.matches});

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;

    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: matches.length,
          itemBuilder: (context, int index){
            return const Text('123');
          }
      )

    );

  }
}