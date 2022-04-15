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
    fabElevation: 10.0,
    animationDuration: Duration(milliseconds: 800),
    ringColor: Color(0xFFb9d8ff),
    ringDiameter: kIsWeb ? 250.0 : screensize.width * 0.6,
    ringWidth: kIsWeb ? 50.0 : (screensize.width * 0.8) / 6,
    fabOpenIcon: Icon(
      Icons.call,
      color: Color(0xFF176ede),
    ),
    fabCloseIcon: Icon(
      Icons.close_rounded,
      color: Color(0xFF176ede),
    ),
    fabCloseColor: Color(0xFFb9d8ff),
    fabOpenColor: Color(0xFFb9d8ff),
    children: <Widget>[
      FloatingItems(
        image: 'assets/police.png',
        number: 'tel:+91 542236 9134',
        title: 'Proctor Office',
      ),
      FloatingItems(
        image: 'assets/ambulance.png',
        number: 'tel:+91 102',
        title: 'Ambulance',
      ),
      FloatingItems(
        image: 'assets/counselor.png',
        number: 'tel:+91 75240 53214',
        title: 'Counselor',
      ),
    ],
  );
}

class FloatingItems extends StatelessWidget {
  const FloatingItems({this.image, this.number, this.title});

  final String image;
  final String number;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launch(number),
      child: Container(
        height: 55.0,
        child: Column(
          children: [
            Container(
              height: 35.0,
              decoration: BoxDecoration(
                  color: Color(0xFFd1e6ff),
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(image))),
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 11.0),
            ),
          ],
        ),
      ),
    );
  }
}
