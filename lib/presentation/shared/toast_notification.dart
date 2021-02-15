import 'package:bot_toast/bot_toast.dart';
import 'package:cryptoboard/business_logic/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomNotification({
  @required String title,
  LoginState state,
  @required IconData icon,
  @required int seconds,
  EdgeInsetsGeometry padding,
  String subtitle,
  @required Color iconColor,
  @required Color iconBackgroundColor,
}) {
  BotToast.showCustomNotification(
    duration: Duration(seconds: seconds),
    onlyOne: true,
    toastBuilder: (void Function() cancelFunc) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.0.w),
        child: Container(
          width: 1.sw,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Color(0xff080E24),
            border: Border.all(
              color: Color(0xff3861FB),
              width: 1.25.w,
              style: BorderStyle.solid,
            ),
          ),
          child: Material(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              tileColor: Color(0xff080E24),
              leading: CircleAvatar(
                radius: 18.r,
                backgroundColor: iconBackgroundColor,
                child: Padding(
                  padding: EdgeInsets.all(4.0.r),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20.r,
                  ),
                ),
              ),
              title: Padding(
                padding: padding,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 8.0.h, bottom: 10.0.h),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xff82899E),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
