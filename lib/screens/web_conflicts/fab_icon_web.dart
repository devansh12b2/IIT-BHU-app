import 'package:flutter/material.dart';

Container getFabIconWeb(String imageUrl, double size) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: imageUrl?.isEmpty != false
            ? AssetImage('assets/iitbhu.jpeg')
            : NetworkImage(imageUrl),
        fit: BoxFit.fill,
      ),
    ),
    height: size,
    width: size,
  );
}
