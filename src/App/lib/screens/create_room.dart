import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/models/room.dart';
import 'package:racket_match/screens/room_instance.dart';
import 'package:racket_match/screens/selector.dart';
import 'package:racket_match/view_models/create_room_view_model.dart';

class CreateRoom extends StatefulWidget{
  const CreateRoom({Key? key}) : super(key: key);


  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  Color backgroundColor = const Color(0xFF1F1A30);
  Color enabledtxt = Colors.white;

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    var roomNameFieldInput = TextEditingController();

    // vm
    var createRoomViewModel = Provider.of<CreateRoomViewModel>(context);

    // TODO: implement build
    return Scaffold(
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
              child: TextButton(
                  onPressed: () {
                    createRoomViewModel
                        .createRoom(roomNameFieldInput.text)
                        .then((object) => {
                          if (object is Room){
                            print(object.id),
                            print(object.roomName),
                            print(object.uniqueRoomIdentifier),
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
            if (createRoomViewModel.errorHasOccurred)
               FadeAnimation(
                 delay: 1,
                 child: Text(createRoomViewModel.errorMessage, style: GoogleFonts.heebo(
                  color: Colors.red,
                  letterSpacing: 0.5,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                )),
              )
          ],
        ),
      ),
    );
  }

}