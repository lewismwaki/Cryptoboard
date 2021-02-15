import 'package:cryptoboard/business_logic/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'forgot_password_sheet.dart';

class CheckEmailScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        settings: RouteSettings(
          name: '/openEmail',
        ),
        builder: (BuildContext context) {
          return CheckEmailScreen();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 150.0.h),
          Center(
            child: Container(
              height: 100.0.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Color(0xffA6B8FD),
              ),
              width: 100.0.h,
              child: Padding(
                padding: EdgeInsets.all(20.0.r),
                child: Image(
                  fit: BoxFit.contain,
                  color: Color(0xff3861FB),
                  image: AssetImage(
                    'assets/images/open_email.png',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0.h),
          Text(
            'Check your Email',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 23.0.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0.h),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return RichText(
                textAlign: TextAlign.center,
                softWrap: true,
                text: TextSpan(
                  text: 'We have sent a password\nrecovery link to',
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: Color(0xff82899E),
                  ),
                  children: [
                    TextSpan(
                      text: " ${state.email.value}",
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff3861FB),
                      ),
                    ),
                    TextSpan(
                      text: '!',
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        color: Color(0xff82899E),
                      ),
                    ),
                    TextSpan(
                      text: '\nThe link expires after 1 hour',
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        color: Color(0xff82899E),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 40.0.h),
          RawMaterialButton(
            onPressed: () async {},
            elevation: 0.0,
            constraints: BoxConstraints(
              maxWidth: 276.w,
              minWidth: 276.w,
              minHeight: 48.0.h,
              maxHeight: 48.0.h,
            ),
            shape: StadiumBorder(),
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.0.sp,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            fillColor: Color(0xff3861FB),
            child: Text('Open Email App'),
          ),
          RawMaterialButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isDismissible: true,
                enableDrag: true,
                isScrollControlled: true,
                barrierColor: Color(0xffA6B8FD).withAlpha(10),
                clipBehavior: Clip.hardEdge,
                routeSettings: RouteSettings(
                  name: '/fromCheckEmailScreen',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                builder: (context) => ForgotPasswordSheet(),
              );
            },
            elevation: 0.0,
            constraints: BoxConstraints(
              maxWidth: 276.w,
              minWidth: 276.w,
              minHeight: 48.0.h,
              maxHeight: 48.0.h,
            ),
            shape: StadiumBorder(),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w600,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            fillColor: Colors.transparent,
            child: Text(
              'Re-enter email',
            ),
          ),
          SizedBox(height: 278.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Did not receive the email? Re-check your email \naddress, ',
              style: TextStyle(
                fontSize: 13.0.sp,
                color: Color(0xff82899E),
              ),
              children: [
                TextSpan(
                  text: 'or check your spam folder.',
                  style: TextStyle(
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3861FB),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0.h),
        ],
      ),
    );
  }
}
