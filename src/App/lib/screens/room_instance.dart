import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:racket_match/Widgets/match_graphic.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/models/match.dart';
import 'package:racket_match/models/player.dart';
import 'package:racket_match/models/room.dart';
import 'package:racket_match/services/hub_clients/on_connection_join.dart';
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
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    ValueNotifier<bool> isAtBotom = ValueNotifier(false);



    return ViewModelBuilder<RoomInstanceViewModel>.reactive(
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
                    SpeedDialChild(
                        child: const Icon(Icons.share_rounded),
                        label: 'Share',
                        backgroundColor: Colors.blue,
                        onTap: (){
                          print('Share Tapped');
                          model.updateMatch(match1);
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
                        onLongPressCallback: (index) async => model.onLongPressOnMatch(index),
                          matches: model.matches
                      ),
                      /*ElevatedButton(
                        onPressed: (){
                          model.updateMatch(match1);
                        },
                        child: const Text('123'),
                      )

                       */
                    ],
                  ),
                )

            ),
    );
  }

}