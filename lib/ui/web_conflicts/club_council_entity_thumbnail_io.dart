import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iit_app/model/appConstants.dart';

Container getClubThumbnailIO(
    bool horizontal, int id, String clubTypeForHero, String imageUrl) {
  File logoFile = AppConstants.getImageFile(imageUrl);
  if (logoFile == null) {
    AppConstants.writeImageFileIntoDisk(imageUrl);
  }
  logoFile = AppConstants.getImageFile(imageUrl);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    alignment:
        horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
    child: Hero(
      tag: "club-hero-$id-$clubTypeForHero",
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            fit: BoxFit.contain,
            image: imageUrl == null || imageUrl == ''
                ? AssetImage('assets/iitbhu.jpeg')
                : logoFile == null
                    ? NetworkImage(imageUrl)
                    : FileImage(logoFile),
          ),
        ),
        height: horizontal ? 50 : 82,
        width: horizontal ? 50 : 82,
      ),
    ),
  );
}

Container getEntityThumbnailIO(
    bool horizontal, int id, String entityTypeForHero, String imageUrl) {
  File logoFile = AppConstants.getImageFile(imageUrl);
  if (logoFile == null) {
    AppConstants.writeImageFileIntoDisk(imageUrl);
  }
  logoFile = AppConstants.getImageFile(imageUrl);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    alignment:
        horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
    child: Hero(
      tag: "entity-hero-$id-$entityTypeForHero",
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            fit: BoxFit.contain,
            image: imageUrl == null || imageUrl == ''
                ? AssetImage('assets/iitbhu.jpeg')
                : logoFile == null
                    ? NetworkImage(imageUrl)
                    : FileImage(logoFile),
          ),
        ),
        height: horizontal ? 50 : 82,
        width: horizontal ? 50 : 82,
      ),
    ),
  );
}

Container getCouncilThumbnailIO(bool horizontal, int id, String imageUrl) {
  File logoFile = AppConstants.getImageFile(imageUrl);
  if (logoFile == null) {
    AppConstants.writeImageFileIntoDisk(imageUrl);
  }
  logoFile = AppConstants.getImageFile(imageUrl);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.center,
    child: Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          fit: BoxFit.contain,
          image: imageUrl == null || imageUrl == ''
              ? AssetImage('assets/iitbhu.jpeg')
              : logoFile == null
                  ? NetworkImage(imageUrl)
                  : FileImage(logoFile),
        ),
      ),
      height: 92.0,
      width: 92.0,
    ),
  );
}

Container getPanelBackgroundImageIO(
    File largeLogoFile, String large_image_url) {
  return Container(
    child: largeLogoFile != null
        ? Image.file(largeLogoFile, fit: BoxFit.cover, height: 300.0)
        : large_image_url != null && large_image_url != ''
            ? Image.network(large_image_url, fit: BoxFit.cover, height: 300.0)
            : Image(image: AssetImage('assets/iitbhu.jpeg')),
    constraints: BoxConstraints.expand(height: 295.0),
  );
}
