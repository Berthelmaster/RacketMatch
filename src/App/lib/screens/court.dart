import 'package:flutter/material.dart';

// Join a room or create one
class Court extends StatelessWidget{
  const Court({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
              Navigator.pushNamed(context, 'court');
            }, child: const Text('Go to next screen'))
          ],
        ),
      ),
    );
  }


}