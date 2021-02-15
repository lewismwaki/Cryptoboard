import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AviError extends StatelessWidget {
  final String icon;
  const AviError({Key key, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 19.r,
      backgroundColor: Color(0xff303441),
      child: Image(
        image: AssetImage('assets/icons/$icon.png'),
      ),
    );
  }
}
