import 'dart:math';

import 'package:cryptoboard/presentation/shared/web_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UnderConstruction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChromeSafariBrowser browser = new MyChromeSafariBrowser(new WebViewContent());

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.only(left: 80.0.w, right: 80.0.w, top: 60.0.h, bottom: 40.0.h),
            child: Container(
              width: 1.sw,
              height: 200.h,
              color: Colors.black,
              child: Image.asset(
                'assets/gifs/under-construction-${Random().nextInt(9)}.gif',
                fit: BoxFit.fitWidth,
                width: 1.sw,
              ),
            ),
          ),
          Text(
            'PAGE UNDER CONSTRUCTION',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0.sp,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w, top: 20.0.h, bottom: 20.0.h),
            child: RichText(
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 3,
              text: TextSpan(
                text: 'Be sure to check back after subsequent releases on ',
                style: TextStyle(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff82899E),
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => await browser.open(url: 'https://github.com/mwakicodes/cryptoboard/releases'),
                    text: "https://github.com/mwakicodes/cryptoboard/releases ",
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3861FB),
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      MdiIcons.openInNew,
                      color: Color(0xff82899E),
                      size: 15.r,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
