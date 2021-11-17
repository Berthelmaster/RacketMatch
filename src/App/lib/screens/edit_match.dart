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
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return ViewModelBuilder<EditMatchViewModel>.reactive(
        viewModelBuilder: () => EditMatchViewModel(match),
        builder: (context, model, child) =>
          Scaffold(
            backgroundColor: const Color(0xFF1F1A30),
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Column(
                          children: [
                            Text('123'),
                            Text('456')
                          ],
                        ),
                        Column(
                          children: [
                            Text('VS')
                          ],
                        ),
                        Column(
                          children: [
                            Text('123'),
                            Text('456')
                          ],
                        )
                      ],
                    )

                  ],
                )
            ),
          )
    );
  }

}