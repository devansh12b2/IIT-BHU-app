import 'package:flutter/material.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/model/colorConstants.dart';
import 'package:iit_app/screens/newScreens/searchBar.dart';
import 'package:iit_app/ui/search_workshop.dart';

AppBar newWorkshopEventAppBar(BuildContext context, SearchBarWidget searchBarWidget,
    FocusNode focusNode) {
  Size screensize = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: ColorConstants.headingColor,
    automaticallyImplyLeading: false,
    elevation: 10.0,
    leading: IconButton(
      color: ColorConstants.btnColor,
      iconSize: 30,
      icon: Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Container(
          width: screensize.width * 0.60,
          // decoration: BoxDecoration(
          //   color: Color(0xFFb9d8ff),
          //   borderRadius: BorderRadius.circular(40.0),
          // ),
          height: 40,
          child: Center(
            child: searchBarWidget.getSearchTextField(context,
                searchFocusNode: focusNode),
          ),
        ),
        SizedBox(
          width: screensize.width * 0.03,
        ),
        Container(
          padding: EdgeInsets.all(8),
          height: screensize.height * 0.056,
          width: screensize.width * 0.090,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: (AppConstants.currentUser == null ||
                  AppConstants.isGuest == true ||
                  AppConstants.currentUser.photo_url == '')
                  ? AssetImage('assets/guest.png')
                  : NetworkImage(AppConstants.currentUser.photo_url),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    ),
  );
}
