import 'package:flutter/material.dart';

class AuthUnknownScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AuthUnknownScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(),
      ),
    );
  }
}
