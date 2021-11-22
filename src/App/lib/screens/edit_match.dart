import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: he*0.08,
                    ),
                    CheckboxListTile(
                      title: Text(model.checkboxTitle),
                      value: model.isChecked,
                      onChanged: (newValue) {
                        model.toggleIsChecked();
                      },
                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Column(
                          children: <Widget>[
                            Text('123'),
                            if(model.isChecked)
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
                            if(model.isChecked)
                              Text('456')
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text("Preview",
                          style: GoogleFonts.heebo(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 2
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                            },
                            child: Text("Create match",style: GoogleFonts.heebo(
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
                      ],

                    )

                  ],
                )
            ),
          )
    );
  }

}