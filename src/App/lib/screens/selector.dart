import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/screens/create_room.dart';
import 'package:racket_match/view_models/room_selection_view_model.dart';
import 'package:stacked/stacked.dart';

import 'room_instance.dart';

enum Buttons{
  Room_ID,
  Player_Name,
}

// Join a room
class MainView extends StatelessWidget{
  MainView({Key? key}) : super(key: key);

  Color enabled = const Color(0xFF827F8A);

  Color enabledtxt = Colors.white;

  Color deaible = Colors.grey;

  Color backgroundColor = const Color(0xFF1F1A30);

  bool ispasswordev = true;

  Buttons? selected;

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    var roomNameFieldInput = '';

    return ViewModelBuilder<RoomSelectionViewModel>.reactive(
        viewModelBuilder: () => RoomSelectionViewModel(),
        builder: (context, model, child) => Scaffold(
            backgroundColor: const Color(0xFF1F1A30),
            body: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: we,
                      height: he,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FadeAnimation(delay: 0.8
                              ,child: const Image(image:
                              AssetImage('lib/assets/images/job-starting-date-2537382-2146478.png'),
                                  height: 300,
                                  fit: BoxFit.cover
                              )
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              child: Text("Select Room",style: GoogleFonts.heebo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  letterSpacing: 2
                              ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: he * 0.01,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              child: Text("Ask for the room ID from your instructor",style: GoogleFonts.heebo(
                                  color: Colors.grey,
                                  letterSpacing: 0.5
                              ),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: he * 0.04,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              width: we * 0.9,
                              height:he * 0.071,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: selected == Buttons.Room_ID ?  enabled : backgroundColor,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child:  TextField(
                                onTap: (){
                                },
                                onChanged: (text){
                                  roomNameFieldInput = text;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border:InputBorder.none,
                                  prefixIcon: Icon(Icons.add_box,color: enabledtxt),
                                  hintText: 'Room ID',
                                  hintStyle: TextStyle(
                                    color:  selected == Buttons.Room_ID ? enabledtxt : deaible,
                                  ),
                                ),
                                style:  TextStyle(color:  selected == Buttons.Room_ID ? enabledtxt : deaible, fontWeight:FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: he * 0.02,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: TextButton(
                                onPressed: (){
                                  model.selectRoomByRoomID(roomNameFieldInput);
                                },
                                child: Text("Enter",style: GoogleFonts.heebo(
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
                          SizedBox(
                            height: he * 0.01,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:  [
                                Text("Don't have an room?",style: GoogleFonts.heebo(
                                  color:   Colors.grey,
                                  letterSpacing: 0.5,
                                )),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return CreateRoom();
                                    }
                                    ));
                                  },
                                  child: Text(" Create one",style: GoogleFonts.heebo(
                                    color:  const Color(0xFF0DF5E4).withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}