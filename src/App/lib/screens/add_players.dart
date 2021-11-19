import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/view_models/add_players_view_model.dart';
import 'package:racket_match/widgets/player_with_cta_textfield.dart';
import 'package:stacked/stacked.dart';

class AddPlayers extends StatelessWidget {
  AddPlayers({Key? key}) : super(key: key);

  final _addPlayerInputController = TextEditingController();
  Color colorWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    // TODO: implement build
    return ViewModelBuilder<AddPlayersViewModel>.reactive(
        viewModelBuilder: () => AddPlayersViewModel(),
        builder: (context, model, child) =>
            Scaffold(
              backgroundColor: const Color(0xFF1F1A30),
              body: FadeAnimation(
                delay: 0.5,
                child: Center(
                  child: Container(
                    width: we * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: he*0.05,
                        ),
                        TextField(
                          controller: _addPlayerInputController,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border:InputBorder.none,
                            prefixIcon: const Icon(Icons.add_box,color: Colors.white),
                            hintStyle: TextStyle(
                                color:  colorWhite
                            ),
                            hintText: 'Add player',
                          ),
                          style:  TextStyle(
                            color:  colorWhite,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                        PlayerWithCtaTextField('Thomas Berthelsen', 1, model.OnDelete)
                      ],
                    ),
                  ),
                ),
              ),
            )
    );
  }

}