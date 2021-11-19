import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/view_models/add_players_view_model.dart';
import 'package:racket_match/widgets/player_with_cta_textfield.dart';
import 'package:stacked/stacked.dart';

class AddPlayers extends StatelessWidget {
  AddPlayers({Key? key, this.roomId}) : super(key: key);

  final int? roomId;
  final _addPlayerInputController = TextEditingController();
  Color colorWhite = Colors.white;
  var player = Player(id: 1, name: 'Thomas Berthelsen', team: 1);



  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;


    // TODO: implement build
    return ViewModelBuilder<AddPlayersViewModel>.reactive(
        viewModelBuilder: () => AddPlayersViewModel(roomId!),
        builder: (context, model, child) =>
            Scaffold(
              backgroundColor: const Color(0xFF1F1A30),
              body: FadeAnimation(
                delay: 0.5,
                child: Center(
                  child: SizedBox(
                    width: we * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: he*0.08,
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
                        FadeAnimation(
                          delay: 1,
                          child: model.isLoading ?
                          const CircularProgressIndicator(
                          )
                              : Center(
                                child: TextButton(
                                onPressed: () {
                                  model.addPlayer(_addPlayerInputController.text);
                                },
                                child: Text("Create player",style: GoogleFonts.heebo(
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                                style:  TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF0DF5E4),
                                    padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 80),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0)
                                    )
                                )
                          ),
                              ),
                        ),
                        SizedBox(
                          height: he*0.04,
                        ),
                        Center(
                          child: Text("List of players",style: GoogleFonts.heebo(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              letterSpacing: 2
                          ),
                          ),
                        ),
                      Expanded(
                          flex: 1,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              reverse: true,
                              itemCount: model.players.length,
                              itemBuilder: (context, index) =>
                                  PlayerWithCtaTextField(
                                    name: model.players[index].name,
                                    id: model.players[index].id,
                                    onDeletePlayerCallback: model.onDelete,
                                  ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
    );
  }

}