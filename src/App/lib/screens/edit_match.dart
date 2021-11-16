import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racket_match/models/match.dart';
import 'package:racket_match/view_models/edit_match_view_model.dart';
import 'package:stacked/stacked.dart';

class EditMatch extends StatelessWidget{
  EditMatch({Key? key, this.match}) : super(key: key);

  final Match? match;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditMatchViewModel>.reactive(
        viewModelBuilder: () => EditMatchViewModel(),
        builder: (context, model, child) =>
          Scaffold(
            body: Text(match!.id.toString()),
          )
    );
  }

}