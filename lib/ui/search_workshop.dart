import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/external_libraries/fab_circular_menu.dart';
import 'package:iit_app/model/built_post.dart';
import 'package:iit_app/model/colorConstants.dart';
import 'package:iit_app/ui/text_style.dart';

class SearchBarWidget {
  TextEditingController searchController = TextEditingController();
  var searchPost;
  final ValueNotifier<bool> isSearching;

  SearchBarWidget(this.isSearching);

  Widget getSearchTextField(context,
      {GlobalKey<FabCircularMenuState> fabKey, FocusNode searchFocusNode}) {
    return StatefulBuilder(
      builder: (context, setState) => TextFormField(
        style: GoogleFonts.notoSans(
          textStyle: TextStyle(fontSize: 18,
              // height: 2.0
          ),
          fontWeight: FontWeight.w500,
          color: Color(0xFFb9d8ff)
        ),
        focusNode: searchFocusNode,
        onTap: () {
          print('====================');
          if (fabKey.currentState.isOpen) {
            fabKey.currentState.close();
          }
        },
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search Workshops ...',
          hintStyle:
              Style.baseTextStyle.copyWith(color: ColorConstants.btnColor),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 30.0,
            color: ColorConstants.btnColor,
          ),
          suffixIcon: IconButton(
            icon: isSearching.value
                ? Icon(Icons.clear, color: ColorConstants.btnColor)
                : Container(),
            onPressed: () {
              setState(() {
                searchController.clear();
                isSearching.value = false;
                searchFocusNode.unfocus();
              });
            },
          ),
        ),
        onFieldSubmitted: (value) {
          if (value.isEmpty) return;

          setState(() {
            isSearching.value = false;
            isSearching.value = true;

            searchPost = BuiltWorkshopSearchByStringPost((b) => b
              ..search_by = 'title'
              ..search_string = searchController.text);
          });
        },
      ),
    );
  }
}
