import 'package:flutter/material.dart';

// TODO: a set of final colors for light and dark theme
// TODO: maintain shadow colors
class ColorConstants {
  static Color homeBackground;
  static Color circularRingBackground;
  static Color shimmerSkeletonColor;
  static Color workshopContainerBackground;
  static Color workshopCardContainer;

  static Color backgroundThemeColor;
  static Color panelColor;
  static Color headingColor;
  static Color porHolderBackground;
  static Color textColor;
  static Color grievanceBtn;
  static Color grievanceLabelText;
  static Color grievanceBack;
  static Color btnColor;
  static Color iconColor;
  static Color porTextColor;

  static setLight() {
    ColorConstants.homeBackground = Color(0xffFFFFFF);
    ColorConstants.circularRingBackground = Color(0xff176EDE);
    ColorConstants.shimmerSkeletonColor = Color(0xffB9D8FF);
    ColorConstants.workshopContainerBackground = Color(0xffFFFFFF);
    ColorConstants.workshopCardContainer = Color(0xFFF3F9FF);
    ColorConstants.backgroundThemeColor = Color.fromRGBO(23, 110, 222, 0.75);
    ColorConstants.panelColor = Colors.white;
    ColorConstants.headingColor = Color(0xff176EDE);
    ColorConstants.porHolderBackground = Color(0xff176EDE);
    ColorConstants.textColor =  Colors.black;
    ColorConstants.grievanceBtn = Color(0xff176EDE);
    ColorConstants.grievanceBack = Color(0xffB9D8FF);
    ColorConstants.grievanceLabelText = Color(0xffD7F2FF);
    ColorConstants.btnColor = Color(0xffB9D8FF);
    ColorConstants.iconColor = Color(0xff176EDE);
    ColorConstants.porTextColor = Color(0xffF3F9FF);
  }

  static setDark() {
    ColorConstants.homeBackground = Color(0xff2c2c2c);
    ColorConstants.circularRingBackground = Colors.black.withOpacity(0.2);
    ColorConstants.shimmerSkeletonColor = Color(0xff3e3d32);
    ColorConstants.workshopContainerBackground = Color(0xff20232a);
    ColorConstants.workshopCardContainer = Color(0xff3e3e3e);
    ColorConstants.backgroundThemeColor = Color(0xFF272822);
    ColorConstants.panelColor = Color(0xff1e1f1c);
    ColorConstants.headingColor = Color(0xFF5dbcd2);
    ColorConstants.porHolderBackground = Color(0xff5dbcd2);
    ColorConstants.textColor = Colors.white;
    // to be changed after dark theme design are done
    ColorConstants.grievanceBtn = Color(0xff176EDE);
    ColorConstants.grievanceBack = Color(0xffB9D8FF);
    ColorConstants.grievanceLabelText = Color(0xffD7F2FF);
    ColorConstants.btnColor = Color(0xffB9D8FF);
    ColorConstants.iconColor = Color(0xff176EDE);
    ColorConstants.porTextColor = Color(0xffF3F9FF);
  }
}
