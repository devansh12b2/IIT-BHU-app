import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/pages/mess/hostel.dart';
import 'package:iit_app/pages/mess/mess_details.dart';
import 'package:iit_app/ui/drawer.dart';

class MessListScreen extends StatelessWidget {
  final Hostel hostel;
  MessListScreen({Key key, this.hostel}) : super(key: key);
  final Color primaryColor = Color(0xFF176EDE);
  final Color bgColor = Color(0xFFFFFFFF);
  final Color secondaryColor = Color(0xFFBBD9FF);
  final Color containerColor = Color(0xFFF3F9FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: SideBar(context: context),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return messItem(hostel.messes[index], context,
                "${hostel.hostelName} Mess ${index + 1}");
          },
          itemCount: hostel.messes.length,
        ),
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
      title: Text(
        hostel.hostelName,
        style: TextStyle(
          color: secondaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
      ),
      actions: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  height: 35.0,
                  width: 35.0,
                  child: Builder(builder: (context) => Container()),
                  decoration: AppConstants.isGuest
                      ? BoxDecoration()
                      : BoxDecoration(
                          image: DecorationImage(
                              image: AppConstants.currentUser == null ||
                                      AppConstants.currentUser.photo_url == ''
                                  ? AssetImage('assets/guest.png')
                                  : NetworkImage(
                                      AppConstants.currentUser.photo_url),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  InkWell messItem(Mess messData, BuildContext context, String name) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessDetails(messData,name)));
      },
      splashColor: primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              elevation: 3,
              shadowColor: containerColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.height * 0.17,
                decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Container(),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
