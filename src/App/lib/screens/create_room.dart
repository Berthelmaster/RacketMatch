import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/models/room.dart';
import 'package:racket_match/screens/room_instance.dart';
import 'package:racket_match/screens/room_selector.dart';
import 'package:racket_match/view_models/create_room_view_model.dart';
import 'package:stacked/stacked.dart';

class CreateRoom extends StatelessWidget{
  CreateRoom({Key? key}) : super(key: key);

  Color backgroundColor = const Color(0xFF1F1A30);
  Color enabledtxt = Colors.white;
  final roomNameFieldInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return ViewModelBuilder<CreateRoomViewModel>.reactive(
        viewModelBuilder: () => CreateRoomViewModel(),
        builder: (context, model, child) =>
            Scaffold(
              backgroundColor: const Color(0xFF1F1A30),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: we * 0.9,
                        height:he * 0.071,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: backgroundColor,
                        ),
                        child:  TextField(
                          controller: roomNameFieldInput,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border:InputBorder.none,
                            prefixIcon: Icon(Icons.add_box,color: enabledtxt),
                            hintStyle: TextStyle(
                                color:  enabledtxt
                            ),
                            hintText: 'Room name',

                          ),
                          style:  TextStyle(
                            color:  enabledtxt,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: model.isLoading ?
                      const CircularProgressIndicator(
                      )
                      : TextButton(
                          onPressed: () {
                            model
                                .createRoom(roomNameFieldInput.text)
                                .then((object) => {
                              if (object is Room){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                  return RoomInstance(room: object);
                                }))
                              }
                            });
                          },
                          child: Text("Create room",style: GoogleFonts.heebo(
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
                      height: he * 0.02,
                    ),
                    if (model.errorHasOccurred)
                      FadeAnimation(
                        delay: 1,
                        child: Text(model.errorMessage, style: GoogleFonts.heebo(
                          color: Colors.red,
                          letterSpacing: 0.5,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                      )
                  ],
                ),
              ),
            )
    );
  }
}