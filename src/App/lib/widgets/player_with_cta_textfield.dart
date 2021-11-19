import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racket_match/animation/fadeanimation.dart';

class PlayerWithCtaTextField extends StatelessWidget {
  final String name;
  final int id;
  final Function(int id) onDeletePlayerCallback;

  Color colorWhite = Colors.white;

  PlayerWithCtaTextField({ required this.name, required this.id,required this.onDeletePlayerCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      padding: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      child: FadeAnimation(
        delay: 0.1,
        child: Row(
          children: [
            Container(
              width: 22.0,
              margin: const EdgeInsets.only(
                right: 14.0,
              ),
              child: IconButton(
                splashRadius: 1,
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 24,
                ),
                onPressed: () => {
                  onDeletePlayerCallback(id)
                },
                tooltip: 'Removes player',
              )
            ),
            Flexible(
              child: Text(
                name,
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}