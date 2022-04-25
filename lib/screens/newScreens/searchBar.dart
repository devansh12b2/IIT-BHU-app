import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/external_libraries/fab_circular_menu.dart';
import 'package:iit_app/model/built_post.dart';

class NewSearchBarWidget {
  TextEditingController searchController = TextEditingController();
  var searchPost;
  final ValueNotifier<bool> isSearching;

  NewSearchBarWidget(this.isSearching);

  Widget getSearchTextField(context,
      {GlobalKey<FabCircularMenuState> fabKey, FocusNode focusNode}) {
    return StatefulBuilder(
      builder: (context, setState) => TextFormField(
        style: GoogleFonts.notoSans(
          textStyle: TextStyle(fontSize: 18, height: kIsWeb ? 1.5 : 1.7),
          fontWeight: FontWeight.w500,
        ),
        focusNode: focusNode,
        textAlign: TextAlign.start,
        onTap: () {
          // if (fabKey.currentState.isOpen) {
          //   fabKey.currentState.close();
          // }
        },
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.black38),
          contentPadding: EdgeInsets.symmetric(vertical: kIsWeb ? 12.0 : 6.5),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 30.0,
            color: Color(0xFF176ede),
          ),
          suffixIcon: IconButton(
            icon: isSearching.value
                ? Icon(Icons.clear, color: Colors.black)
                : Container(),
            onPressed: () {
              setState(() {
                searchController.clear();
                isSearching.value = false;
                focusNode.unfocus();
              });
            },
          ),
        ),
        onFieldSubmitted: (value) {
          if (value.isEmpty) return;

          setState(
            () {
              isSearching.value = false;
              isSearching.value = true;

              searchPost = BuiltWorkshopSearchByStringPost((b) => b
                ..search_by = 'title'
                ..search_string = searchController.text);
            },
          );
        },
      ),
    );
  }
}
