import 'package:flutter/material.dart';

class FutureUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "Feature coming soon!",
        style: TextStyle(
          fontFamily: 'Gilroy',
          color: Color(0xFF176ede),
          letterSpacing: .2,
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ));
  }
}
