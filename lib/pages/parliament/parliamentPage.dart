import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/pages/parliament/contactsScreen.dart';
import 'package:iit_app/pages/parliament/minutesScreen.dart';
import 'package:iit_app/pages/parliament/yourVoteScreen.dart';

class ParliamentPage extends StatefulWidget {
  // const ParliamentMainPage({ Key? key }) : super(key: key);
  // static const String routName = '/parliament-home';

  @override
  _ParliamentPageState createState() => _ParliamentPageState();
}

class _ParliamentPageState extends State<ParliamentPage> {
  Color primaryColor = Color(0xFF176EDE);
  Color bgColor = Color(0xFFFFFFFF);
  Color secondaryColor = Color(0xFFBBD9FF);
  Color containerColor = Color(0xFFF4F9FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          tile((){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VoteScreen()));
          },"Tips", "Your Vote", "Your suggestions \nand opinions", Colors.blue[100], Colors.blue, context),
          tile((){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MinutesScreen()));
          },"Update", "Minutes", "Committees and \ntheir updates.",
              Colors.orange[200], Colors.orange, context),
          tile((){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ContactsScreen()));
          },"Connect", "Contacts", "Committees and \ntheir contacts.",
              Colors.green[200], Colors.green, context),
        ],
      ),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: secondaryColor,
        iconSize: 30,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Parliament',
            style: GoogleFonts.lato(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 23,
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 35.0,
            width: 35.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (AppConstants.currentUser == null ||
                    AppConstants.isGuest == true ||
                    AppConstants.currentUser.photo_url == '')
                    ? AssetImage('assets/guest.png')
                    : NetworkImage(AppConstants.currentUser.photo_url),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(color: Colors.blueGrey, width: 2.0),
            ),
          )
        ],
      ),
    );
  }
  Widget tile(Function onPressed,String tag, String title, String subtitle, Color hintBoxColor,
      Color hintColor, BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width*0.65,
          decoration: BoxDecoration(
            color: Color(0xFFEDF7FF),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: hintBoxColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                            child: Text(tag,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                color: hintColor,
                              ),
                            ),
                          ),
                        ),
                        Text(title,
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w900
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Text(subtitle,
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          color: primaryColor,
                          //fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
                Icon(Icons.lock_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
