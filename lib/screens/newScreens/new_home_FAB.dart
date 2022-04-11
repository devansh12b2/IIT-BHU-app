// import 'package:iit_app/external_libraries/fab_circular_menu.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      FloatingItems(image: 'assets/siren.png', number: 'tel:+91 88888888888'),
      FloatingItems(image: 'assets/siren.png', number: 'tel:+91 88888888888'),
      FloatingItems(image: 'assets/siren.png', number: 'tel:+91 88888888888'),
    ],
  );
}

class FloatingItems extends StatelessWidget {
  const FloatingItems({this.image, this.number});

  final String image;
  final String number;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launch(number),
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
            color: Color(0xFF176ede),
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage(image))),
      ),
    );
  }
}
