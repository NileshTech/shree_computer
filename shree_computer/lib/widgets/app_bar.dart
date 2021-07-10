import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

Widget appBarContainer(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height / 6,
    width: size.width / 2,
    alignment: Alignment.centerRight,
    child: Column(
      children: [
        Expanded(
          flex: 4,
          child: Image.asset(
            "assets/shree_computer.jpg",
          ),
        ),
        Expanded(
            child: Text("श्री Computer, Gangakhed",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)))
      ],
    ),
  );
}
