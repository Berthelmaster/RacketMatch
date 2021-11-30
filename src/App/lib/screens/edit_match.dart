import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racket_match/models/match.dart';
import 'package:racket_match/view_models/edit_match_view_model.dart';
import 'package:racket_match/widgets/match_graphic.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:stacked/stacked.dart';

class EditMatch extends StatelessWidget {
  EditMatch({Key? key, this.match, this.roomId}) : super(key: key);

  final Match? match;
  final int? roomId;
  String? playerOneSearchHighlighted;
  String? playerTwoSearchHighlighted;
  String? playerThreeSearchHighlighted;
  String? playerFourSearchHighlighted;
  final playerOneController = TextEditingController();
  final playerTwoController = TextEditingController();
  final playerThreeController = TextEditingController();
  final playerFourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return ViewModelBuilder<EditMatchViewModel>.reactive(
        viewModelBuilder: () => EditMatchViewModel(match, roomId!),
        onModelReady: (model) async => {
              await model.fetchPlayers(),
            },
        builder: (context, model, child) => Scaffold(
              backgroundColor: const Color(0xFF1F1A30),
              body: Center(
                  child: SizedBox(
                width: we * 0.95,
                child: Column(
                  children: [
                    SizedBox(
                      height: he * 0.08,
                    ),
                    CheckboxListTile(
                      title: Text(model.checkboxTitle),
                      value: model.isChecked,
                      onChanged: (newValue) {
                        model.toggleIsChecked();
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text('Team 1'),
                              ),
                              TextField(
                                controller: playerOneController,
                                readOnly: true,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  label: Text("Player 1",
                                      style: GoogleFonts.heebo(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal)),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                onTap: () => SelectDialog.showModal<String>(
                                  context,
                                  label: "Select player 1",
                                  titleStyle:
                                      const TextStyle(color: Colors.brown),
                                  onFind: (String filter) =>
                                      model.filterByValue(filter),
                                  showSearchBox: true,
                                  selectedValue: playerOneSearchHighlighted,
                                  backgroundColor: Colors.white,
                                  items: model.getPlayersByName(),
                                  onChange: (String selected) async {
                                    playerOneSearchHighlighted = selected;
                                    playerOneController.text = selected;
                                    await model.addedPlayerToMatch(selected, 0);
                                  },
                                ),
                              ),
                              if (model.isChecked)
                                TextField(
                                  controller: playerTwoController,
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    label: Text("Player 2",
                                        style: GoogleFonts.heebo(
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onTap: () => SelectDialog.showModal<String>(
                                    context,
                                    label: "Select player 2",
                                    titleStyle:
                                        const TextStyle(color: Colors.brown),
                                    onFind: (String filter) =>
                                        model.filterByValue(filter),
                                    showSearchBox: true,
                                    selectedValue: playerTwoSearchHighlighted,
                                    backgroundColor: Colors.white,
                                    items: model.getPlayersByName(),
                                    onChange: (String selected) async {
                                      playerTwoSearchHighlighted = selected;
                                      playerTwoController.text = selected;
                                      await model.addedPlayerToMatch(selected, 1);
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                          children: [Text('VS')],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text('Team 2'),
                              ),
                              TextField(
                                controller: playerThreeController,
                                readOnly: true,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  label: Text("Player 3",
                                      style: GoogleFonts.heebo(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal)),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                onTap: () => SelectDialog.showModal<String>(
                                  context,
                                  label: "Select player 3",
                                  titleStyle: TextStyle(color: Colors.brown),
                                  onFind: (String filter) =>
                                      model.filterByValue(filter),
                                  showSearchBox: true,
                                  selectedValue: playerThreeSearchHighlighted,
                                  backgroundColor: Colors.white,
                                  items: model.getPlayersByName(),
                                  onChange: (String selected) async {
                                    playerThreeSearchHighlighted = selected;
                                    playerThreeController.text = selected;
                                    await model.addedPlayerToMatch(selected, 2);
                                  },
                                ),
                              ),
                              if (model.isChecked)
                                TextField(
                                  controller: playerFourController,
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    label: Text("Player 4",
                                        style: GoogleFonts.heebo(
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onTap: () => SelectDialog.showModal<String>(
                                    context,
                                    label: "Select player 4",
                                    titleStyle: TextStyle(color: Colors.brown),
                                    onFind: (String filter) =>
                                        model.filterByValue(filter),
                                    showSearchBox: true,
                                    selectedValue: playerFourSearchHighlighted,
                                    backgroundColor: Colors.white,
                                    items: model.getPlayersByName(),
                                    onChange: (String selected) async {
                                      playerFourSearchHighlighted = selected;
                                      playerFourController.text = selected;
                                      await model.addedPlayerToMatch(selected, 3);
                                    },
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Preview",
                          style: GoogleFonts.heebo(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              letterSpacing: 2),
                        ),
                        MatchGraphic(
                            teamOne: model.teamOne,
                            teamTwo: model.teamTwo,
                            isInFocus: false),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Create match",
                                style: GoogleFonts.heebo(
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF0DF5E4),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ));
  }
}
