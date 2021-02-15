import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BaseCurrency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.0.h,
      minWidth: 0.0.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: Color(0xff323546),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      onPressed: () {
        showCustomNotification(
          title: 'Feature still in development',
          subtitle: 'Be sure to check after subsequent releases',
          icon: MdiIcons.beta,
          iconColor: Colors.white,
          iconBackgroundColor: Color(0xff555E8D),
          seconds: 3,
          padding: EdgeInsets.only(top: 8.0.h),
        );
      },
      child: Text(
        'USD',
        style: normalText,
      ),
    );
  }
}
