import 'package:flutter/material.dart';

getLogoImageFileWeb(String logoImageUrl) {
  return logoImageUrl == null || logoImageUrl == ''
      ? Image.asset('assets/iitbhu.jpeg', fit: BoxFit.cover, height: 300.0)
      : Image.network(logoImageUrl, fit: BoxFit.cover, height: 300.0);
}

getProviderImageFileWeb(String logoImageUrl) {
  return logoImageUrl == null || logoImageUrl == ''
      ? AssetImage('assets/iitbhu.jpeg')
      : NetworkImage(logoImageUrl);
}
