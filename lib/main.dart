import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iit_app/model/colorConstants.dart';
import 'package:iit_app/pages/Init_Root/initiation.dart';
import 'package:iit_app/pages/Init_Root/root.dart';
import 'package:iit_app/pages/account/newProfilePage.dart';
import 'package:iit_app/pages/academics/academicsPage.dart';
import 'package:iit_app/pages/allEntities/allEntitiesPage.dart';
import 'package:iit_app/pages/grievance/grievance.dart';
import 'package:iit_app/pages/lostAndFound/lostFound.dart';
import 'package:iit_app/pages/map/mapPage.dart';
import 'package:iit_app/pages/mess/mess.dart';
import 'package:iit_app/pages/account/accountPage.dart';
import 'package:iit_app/pages/allWorkshops/allWorkshopsPage.dart';
import 'package:iit_app/pages/complaints/complaints.dart';
import 'package:iit_app/pages/Home/homePage.dart';
import 'package:iit_app/pages/login/loginPage.dart';
import 'package:iit_app/pages/about/aboutPage.dart';

import 'package:iit_app/pages/parliament/parliamentPage.dart';

import 'package:iit_app/pages/newHomePage/newHomePage.dart';

import 'package:iit_app/pages/settings/settingsPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MaterialApp(
    title: 'Lite Hai!',
    theme: ThemeData(
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: ColorConstants.textColor,
        displayColor: ColorConstants.textColor,
      ),
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/init',
    // define the routes
    routes: <String, WidgetBuilder>{
      '/init': (BuildContext context) => Initiation(),

      //! '/root' is root route and should always remain in navigator stack, period. (so that FCM notification will always have a stable context to act upon)

      '/root': (BuildContext context) => RootPage(),
      // '/newhome': (BuildContext context) => NewHomeScreen(),
      '/newhome': (BuildContext context) => NewHomePage(),
      '/home': (BuildContext context) => HomePage(),
      '/mapPage': (BuildContext context) => MapPage(),
      '/academicsPage': (BuildContext context) => AcademicsPage(),
      '/mess': (BuildContext context) => MessScreen(),
      '/allWorkshops': (BuildContext context) => AllWorkshopsScreen(),
      '/allEntities': (BuildContext context) => EntitiesPage(),
      '/parliamentPage': (BuildContext context) => ParliamentPage(),
      '/newProfile': (BuildContext context) => ProfilePage(),
      '/account': (BuildContext context) => AccountPage(),
      '/Mess': (BuildContext context) => MessScreen(),
      '/settings': (BuildContext context) => SettingsScreen(),
      '/complaints': (BuildContext context) => ComplaintsScreen(),
      '/login': (BuildContext context) => LoginPage(),
      '/about': (BuildContext context) => AboutPage(),
      '/grievance': (BuildContext context) => GrievancePage(),
      '/lostAndFound': (BuildContext context) => LostAndFoundPage(),
    },
  ));
}
