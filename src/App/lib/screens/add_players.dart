import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racket_match/view_models/add_players_view_model.dart';
import 'package:stacked/stacked.dart';

class AddPlayers extends StatelessWidget {
  AddPlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AddPlayersViewModel(),
        builder: (context, model, child) =>
            const Scaffold(
              body: Text('123'),
            )
    );
  }

}