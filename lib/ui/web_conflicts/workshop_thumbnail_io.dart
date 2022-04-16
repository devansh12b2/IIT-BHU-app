import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iit_app/model/built_post.dart';

Container getWorkshopThumbnailIO(
    bool horizontal, bool isClub, BuiltWorkshopSummaryPost w, File logoFile) {
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
                ? (w.club.small_image_url == null ||
                        w.club.small_image_url == ''
                    ? AssetImage('assets/iitbhu.jpeg')
                    : logoFile == null
                        ? NetworkImage(w.club.small_image_url)
                        : FileImage(logoFile))
                : (w.entity.small_image_url == null ||
                        w.entity.small_image_url == ''
                    ? AssetImage('assets/iitbhu.jpeg')
                    : logoFile == null
                        ? NetworkImage(w.entity.small_image_url)
                        : FileImage(logoFile)),
          ),
        ),
        height: 92.0,
        width: 92.0,
      ),
    ),
  );
}
