import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/pages/mess/hostel.dart';
import 'package:iit_app/ui/drawer.dart';

class MessDetails extends StatefulWidget {
  final Mess mess;
  final String name;
  MessDetails(this.mess,this.name);
  @override
  State<MessDetails> createState() => _MessDetailsState(mess,name);
}

class _MessDetailsState extends State<MessDetails> {
  Color primaryColor = Color(0xFF176EDE);

  Color bgColor = Color(0xFFFFFFFF);

  Color secondaryColor = Color(0xFFBBD9FF);

  Color containerColor = Color(0xFFF3F9FF);

  final Mess _mess;
  final String _name;
  _MessDetailsState(this._mess,this._name);

  List _messKiDetails = [
    'Menu',
    'Bills',
    'Complaints & \n Suggestions',
  ];

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
            return hostelItem(_messKiDetails[index]);
          },
          itemCount: _messKiDetails.length,
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
        _name,
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

  InkWell hostelItem(String detailType) {
    return InkWell(
      onTap: () => null,
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
              detailType,
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
