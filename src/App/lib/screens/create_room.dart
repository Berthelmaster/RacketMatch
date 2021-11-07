import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racket_match/animation/fadeanimation.dart';
import 'package:racket_match/screens/selector.dart';

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
                  onTap: (){
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border:InputBorder.none,
                    prefixIcon: Icon(Icons.account_circle,color: enabledtxt),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const Selector();
                        }
                        ));
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
          ],
        ),
      ),
    );
  }

}