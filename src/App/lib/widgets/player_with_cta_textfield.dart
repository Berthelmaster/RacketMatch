import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerWithCtaTextField extends StatelessWidget {
  final String text;
  final int id;
  final Function(int id) OnDeletePlayerCallback;

  Color colorWhite = Colors.white;

  PlayerWithCtaTextField(this.text,this.id, this.OnDeletePlayerCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 22.0,
            margin: const EdgeInsets.only(
              right: 12.0,
            ),
            child: IconButton(
              splashRadius: 1,
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 18,
              ),
              onPressed: () => {
                OnDeletePlayerCallback(id)
              },
              tooltip: 'Removes player',
            )
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: colorWhite,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}