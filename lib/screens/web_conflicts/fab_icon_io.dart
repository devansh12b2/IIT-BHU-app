import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/model/built_post.dart';

Container getFabIconIO(BuiltAllCouncilsPost council, EntityListPost entity,
    String imageUrl, double size) {
  File _imageFile;
  if (council != null) {
    _imageFile = AppConstants.getImageFile(council.small_image_url);
  } else {
    _imageFile = AppConstants.getImageFile(entity.small_image_url);
  }
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: _imageFile != null
            ? FileImage(_imageFile)
            : imageUrl?.isEmpty != false
                ? AssetImage('assets/iitbhu.jpeg')
                : NetworkImage(imageUrl),
        fit: BoxFit.fill,
      ),
    ),
    height: size,
    width: size,
  );
}
