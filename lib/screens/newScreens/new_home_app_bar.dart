import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/screens/newScreens/searchBar.dart';

import '../../model/colorConstants.dart';
import '../../ui/text_style.dart';

AppBar newHomeAppBar(BuildContext context, NewSearchBarWidget searchBarWidget,
    FocusNode focusNode) {
  Size screensize = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: Color(0xFF176ede),
    automaticallyImplyLeading: false,
    elevation: 10.0,
    leading: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          height: 35.0,
          width: 35.0,
          child: Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
                // if (fabKey.currentState.isOpen) {
                //   fabKey.currentState.close();
                // }
              },
              child: Icon(
                Icons.menu_rounded,
                color: Color(0xFFb9d8ff),
                size: 40.0,
              ),
            ),
          ),
        )
        // IconButton(
        //   icon: Icon(
        //     Icons.menu_rounded,
        //     color: Color(0xFFb9d8ff),
        //     size: 40.0,
        //   ),
        //   tooltip: 'Menu Icon',
        //   onPressed: () {},
        // ),
        ),
    title: Padding(
      padding: kIsWeb
          ? EdgeInsets.only(left: screensize.width * 0.05)
          : EdgeInsets.only(left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          //     child: searchBarWidget.getSearchTextField(context,
          //         fabKey: fabKey, searchFocusNode: focusNode)),
          Container(
            width: screensize.width * 0.61,
            decoration: BoxDecoration(
              color: Color(0xFFb9d8ff),
              borderRadius: BorderRadius.circular(40.0),
            ),
            height: 40,
            child: Center(
              child: searchBarWidget.getSearchTextField(context,
                  focusNode: focusNode),
              //   child: TextField(
              //     style: GoogleFonts.notoSans(
              //       textStyle:
              //           TextStyle(fontSize: 14, height: 2.0, letterSpacing: 0.1),
              //       fontWeight: FontWeight.w500,
              //     ),
              //     focusNode: focusNode,
              //     textAlign: TextAlign.start,
              //     decoration: InputDecoration(
              //       contentPadding: EdgeInsets.symmetric(vertical: 2.0),
              //       focusedBorder: InputBorder.none,
              //       enabledBorder: InputBorder.none,
              //       prefixIcon: Icon(
              //         Icons.search_rounded,
              //         size: 30.0,
              //         color: Color(0xFF176ede),
              //       ),
              //     ),
              //     // onSubmitted: (value) {
              //     // Navigator.of(context).push(
              //     //   MaterialPageRoute(
              //     //     builder: (context) => Search(
              //     //       searchVal: value,
              //     //     ),
              //     //   ),
              //     // );
              //     // },
              //   ),
            ),
          ),
          GestureDetector(
            onTap: () {
              AppConstants.isGuest
                  ? ListTile(
                      title: Text("New Profile",
                          style: Style.baseTextStyle
                              .copyWith(color: ColorConstants.textColor)),
                      leading: Icon(Icons.account_box,
                          color: ColorConstants.textColor),
                      onTap: () {
                        Navigator.pop(context);
                        return ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                          elevation: 10,
                          content: Text('You must be logged in'),
                          duration: Duration(seconds: 2),
                        ));
                      },
                    )
                  : Navigator.of(context).pushNamed('/newProfile');
            },
            child: Container(
              padding: EdgeInsets.all(8),
              height: 40,
              width: 40,
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
            ),
          )
        ],
      ),
    ),
  );
}
