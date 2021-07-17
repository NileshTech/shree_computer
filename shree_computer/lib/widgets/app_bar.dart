import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

Widget appBarImage(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container();
}

Widget appBarContainer(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  return Container(
    child: new FlareActor("assets/flare/appBar.flr",
        alignment: Alignment.center, fit: BoxFit.fill, animation: "appbar"),
  );
}
