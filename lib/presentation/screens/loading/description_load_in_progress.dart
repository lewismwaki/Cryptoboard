import 'dart:math';

import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DescriptionLoadInProgress extends StatelessWidget {
  final String symbol;
  final String name;
  const DescriptionLoadInProgress({Key key, this.name, this.symbol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //title
          Text(
            'About $name',
            style: appBarText,
          ),
          SizedBox(height: 16.h),

          //subtitle
          Text(
            'What Is $name (${symbol.toUpperCase()})?',
            style: appBarText.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 32.h),

          //desc
          Shimmer(
            enabled: true,
            direction: ShimmerDirection.ltr,
            gradient: LinearGradient(
              begin: Alignment.center,
              colors: [
                Color(0xff131518),
                Color(0xff2A2F37),
                Color(0xff131518),
              ],
            ),
            child: Container(
              height: 99.0.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          //tags
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 22.h,
                width: (Random().nextInt(40).w + 20).w.roundToDouble().w,
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  color: Colors.black,
                  border: Border.all(
                    color: Color(0xff41444A),
                    width: 1.5.w,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                alignment: Alignment.center,
                height: 22.h,
                width: (Random().nextInt(40).w + 20).w.roundToDouble().w,
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  color: Colors.black,
                  border: Border.all(
                    color: Color(0xff41444A),
                    width: 1.5.w,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),

          Container(
            color: Color(0xff23262D),
            height: 1.h,
            width: 1.sw,
          ),

          //website
          ListTile(
            tileColor: Colors.black,
            dense: true,
            focusColor: Colors.black,
            title: Text(
              'Website',
              style: TextStyle(color: Colors.white, fontSize: 12.0.sp),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18.r,
              color: Colors.white,
            ),
            onTap: () async {},
          ),

          Container(
            color: Color(0xff23262D),
            height: 1.h,
            width: 1.sw,
          ),
        ],
      ),
    );
  }
}
