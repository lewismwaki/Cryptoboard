import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/shared/under_construction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceAlertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            visualDensity: VisualDensity.compact,
            splashRadius: 20.w,
            padding: EdgeInsets.all(0),
            hoverColor: Color(0xff2777FF).withAlpha(80),
            splashColor: Color(0xff2777FF).withAlpha(80),
            highlightColor: Color(0xff2777FF).withAlpha(80),
            icon: Icon(Icons.arrow_back),
          ),
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          title: Text(
            'Price Alerts',
            style: appBarText.copyWith(
              fontSize: 16.0,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            UnderConstruction(),
          ],
        ),
      ),
    );
  }
}
