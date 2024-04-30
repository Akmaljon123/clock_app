import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget clockCard(){
  bool onOff = false;

  return Container(
    height: 75,
    width: 370,
    decoration: BoxDecoration(
      color: CupertinoColors.black,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Colors.grey
      )
    ),
    child: Row(
      children: [
        Icon(
          Icons.alarm,
          color: Colors.white.withOpacity(0.7),
          size: 28,
        ),

        const Text(
          "7:30",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white
          ),
        ),

        Switch(
            value: onOff,
            onChanged: (value) {
              onOff = value;
            }
        )

      ],
    ),
  );
}