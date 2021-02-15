import 'package:app_settings/app_settings.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 80.0.w, right: 80.0.w, top: 20.0.h, bottom: 20.0.h),
          child: Container(
            width: 1.sw,
            color: Colors.black,
            child: Image.asset(
              'assets/images/no-internet.png',
              fit: BoxFit.fitWidth,
              width: 1.sw,
            ),
          ),
        ),
        Text(
          'Oops! An error occurred',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.5.sp,
            color: Color(0xff3861FB),
          ),
        ),
        SizedBox(height: 8.0.h),
        Padding(
          padding: EdgeInsets.only(left: 50.0.w, right: 50.0.w),
          child: Text(
            'Please check your internet connection and we\'ll retry for you :)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff82899E),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 20.0.h, bottom: 20.0.h),
          child: Container(
            height: 48.0.h,
            width: 1.sw,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: MaterialButton(
              height: 48.0.h,
              minWidth: 1.sw,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              focusElevation: 0.0,
              elevation: 0.0,
              child: Text(
                'Turn on',
                style: normalText.copyWith(fontSize: 13.sp),
              ),
              color: Color(0xff323546),
              onPressed: () async {
                await AppSettings.openWIFISettings();
              },
            ),
          ),
        ),
      ],
    );
  }
}
