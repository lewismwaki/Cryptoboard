import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InternalError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      child: Column(
        children: [
          SizedBox(height: 10.0.h),
          Padding(
            padding: EdgeInsets.only(left: 80.0.w, right: 80.0.w, top: 20.0.h, bottom: 20.0.h),
            child: Container(
              width: 200.w,
              color: Colors.black,
              child: Image.asset(
                'assets/images/failed-to-load.png',
                fit: BoxFit.fitWidth,
                width: 200.w,
              ),
            ),
          ),
          SizedBox(height: 10.0.h),
          Text(
            'Oops! An error occurred',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19.0.sp,
              color: Color(0xff3861FB),
            ),
          ),
          SizedBox(height: 8.0.h),
          Padding(
            padding: EdgeInsets.only(left: 50.0.w, right: 50.0.w),
            child: Text(
              'But don\'t fret. This might be an internal server error',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff82899E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
