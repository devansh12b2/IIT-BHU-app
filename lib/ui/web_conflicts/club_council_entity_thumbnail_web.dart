import 'package:flutter/material.dart';

Container getClubThumbnailWeb(
    bool horizontal, int id, String clubTypeForHero, String imageUrl) {
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
                  : NetworkImage(imageUrl)),
        ),
        height: horizontal ? 50 : 82,
        width: horizontal ? 50 : 82,
      ),
    ),
  );
}

Container getEntityThumbnailWeb(
    bool horizontal, int id, String entityTypeForHero, String imageUrl) {
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
                  : NetworkImage(imageUrl)),
        ),
        height: horizontal ? 50 : 82,
        width: horizontal ? 50 : 82,
      ),
    ),
  );
}

Container getCouncilThumbnailWeb(bool horizontal, int id, String imageUrl) {
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
                : NetworkImage(imageUrl)),
      ),
      height: 92.0,
      width: 92.0,
    ),
  );
}

Container getPanelBackgroundImageWeb(String large_image_url) {
  return Container(
    child: large_image_url != null && large_image_url != ''
        ? Image.network(large_image_url, fit: BoxFit.cover, height: 300.0)
        : Image(image: AssetImage('assets/iitbhu.jpeg')),
    constraints: BoxConstraints.expand(height: 295.0),
  );
}
