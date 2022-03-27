// import 'package:iit_app/external_libraries/fab_circular_menu.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

FabCircularMenu newHomeFAB(BuildContext context, {fabKey}) {
  Size screensize = MediaQuery.of(context).size;
  return FabCircularMenu(
    key: fabKey,
    fabMargin: EdgeInsets.only(
        bottom: screensize.height * 0.025, right: screensize.width * 0.03),
    fabIconBorder: CircleBorder(),
    fabSize: 55.0,
    fabElevation: 8.0,
    animationDuration: Duration(milliseconds: 800),
    ringColor: Color(0xFFb9d8ff),
    ringDiameter: kIsWeb ? 250.0 : screensize.width * 0.54,
    ringWidth: kIsWeb ? 50.0 : (screensize.width * 0.8) / 6.6,
    fabOpenIcon: Icon(
      Icons.menu_rounded,
      color: Color(0xFF176ede),
    ),
    fabCloseIcon: Icon(
      Icons.close_rounded,
      color: Color(0xFF176ede),
    ),
    fabCloseColor: Color(0xFFb9d8ff),
    fabOpenColor: Color(0xFFb9d8ff),
    children: <Widget>[
      FloatingItems(),
      FloatingItems(),
      FloatingItems(),
    ],
  );
}

class FloatingItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Container(
        height: 45.0,
        decoration:
            BoxDecoration(color: Color(0xFF176ede), shape: BoxShape.circle),
      ),
    );
  }
}
