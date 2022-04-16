import 'package:flutter/material.dart';
import 'package:iit_app/model/built_post.dart';

Container getWorkshopThumbnailWeb(
    bool horizontal, bool isClub, BuiltWorkshopSummaryPost w) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    alignment:
        horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
    child: Hero(
      tag: "w-hero-${w.id}",
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
              fit: BoxFit.contain,
              image: isClub
                  ? w.club.small_image_url == null ||
                          w.club.small_image_url == ''
                      ? AssetImage('assets/iitbhu.jpeg')
                      : NetworkImage(w.club.small_image_url)
                  : w.entity.small_image_url == null ||
                          w.entity.small_image_url == ''
                      ? AssetImage('assets/iitbhu.jpeg')
                      : NetworkImage(w.entity.small_image_url)),
        ),
        height: 92.0,
        width: 92.0,
      ),
    ),
  );
}
