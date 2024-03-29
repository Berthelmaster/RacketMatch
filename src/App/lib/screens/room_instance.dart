import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/constants.dart';
import 'package:racket_match/models/match.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/models/room.dart';
import 'package:racket_match/screens/add_players.dart';
import 'package:racket_match/screens/edit_match.dart';
import 'package:racket_match/view_models/room_instance_view_model.dart';
import 'package:racket_match/widgets/match_graphic_list.dart';
import 'package:stacked/stacked.dart';

//ignore: must_be_immutable
class RoomInstance extends StatelessWidget{
  RoomInstance({Key? key,  this.room}) : super(key: key);

  late Room? room;

  @override
  Widget build(BuildContext context){
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    Player player1 = Player(id: 1, name: 'Jens Stage Stage', team: Team.team1);
    Player player2 = Player(id: 2, name: 'PLayer_2', team: Team.team1);
    Player player3 = Player(id: 3, name: 'PLayer_3', team: Team.team2);
    Player player4 = Player(id: 4, name: 'PLayer_4', team: Team.team2);

    Match match1 = Match(id: 1, players: [player1, player2, player3, player4]);
    Match match2 = Match(id: 2, players: [player1, player3]);
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);



    return WillPopScope(
      onWillPop: () async {
        bool acceptedLeave = false;

        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Leaving this room will take you to the room selection page, are you sure you want to leave your room?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      acceptedLeave = true;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No'))
              ],
            ));

        return acceptedLeave;
      },
      child: ViewModelBuilder<RoomInstanceViewModel>.reactive(
          viewModelBuilder: () => RoomInstanceViewModel(),
          onModelReady: (model) async => await model.setupHubConnection(room!.uniqueRoomIdentifier.toString()),
          onDispose: (model) async => await model.disposeHubConnection(),
          builder: (context, model, child) =>
                Scaffold(
                  floatingActionButton: FadeAnimation(
                    delay: 0.25,
                    child: SpeedDial(
                      animatedIcon: AnimatedIcons.search_ellipsis,
                      openCloseDial: isDialOpen,
                      backgroundColor: const Color(0xFF0DF5E4).withOpacity(0.6),
                      overlayColor: const Color(0xFF0DF5E4).withOpacity(0.1),
                      overlayOpacity: 0.2,
                      spacing: 15,
                      spaceBetweenChildren: 15,
                      closeManually: false,
                      children: [
                        if(!isReleaseMode)
                          SpeedDialChild(
                              child: const Icon(Icons.share_rounded),
                              label: 'Test',
                              backgroundColor: Colors.blue,
                              onTap: (){
                                model.updateMatch(match1);
                                model.updateMatch(match2);
                              }
                          ),
                        SpeedDialChild(
                            child: const Icon(Icons.account_circle),
                            label: 'Setup players',
                            backgroundColor: Colors.blue,
                            onTap: (){
                              print('Setup players Tapped');
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  print('uniq ${room!.uniqueRoomIdentifier}');
                                return AddPlayers(roomId: room!.id, uniqueRoomIdentifier: room!.uniqueRoomIdentifier);
                              }
                              ));
                            }

                        ),
                        SpeedDialChild(
                            child: const Icon(Icons.add_circle),
                            label: 'Create match',
                            backgroundColor: Colors.blue,
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return EditMatch(roomId: room!.id);
                              }
                              ));
                            }

                        )
                      ],
                    ),
                  ),
                    backgroundColor: const Color(0xFF1F1A30),
                    body: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: he * 0.04,
                          ),
                          Center(
                            child: Text('Room ID: ${room!.uniqueRoomIdentifier.toString()}',
                                style: GoogleFonts.heebo(
                                  color:  const Color(0xFF9746A0).withOpacity(0.9),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,)),
                          ),
                          MatchGraphicList(
                            matches: model.matches,
                            onLongPressCallback: (index) async => await model.onLongPressOnMatch(index),
                            onDeleteCallback: (id) async => await model.onDeletedMatch(id),
                            onEditCallback: (id) async {
                              Match result = await model.onEditedMatch(id);

                              if(result is Match) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return EditMatch(match: result);
                                }));
                              }
                            }
                          ),
                        ],
                      ),
                    )

                ),
      ),
    );
  }

}