import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OneDayPriceLoadInProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //section one
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //open
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Open",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff737A8B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Shimmer(
                      enabled: true,
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff131518),
                          Color(0xff2A2F37),
                          Color(0xff131518),
                        ],
                      ),
                      child: Container(
                        height: 14.0.h,
                        width: (Random().nextInt(60).w + 38).w.roundToDouble().w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                //high
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "High",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff737A8B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Shimmer(
                      enabled: true,
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff131518),
                          Color(0xff2A2F37),
                          Color(0xff131518),
                        ],
                      ),
                      child: Container(
                        height: 14.0.h,
                        width: (Random().nextInt(60).w + 38).w.roundToDouble().w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                //average
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Average",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff737A8B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Shimmer(
                      enabled: true,
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff131518),
                          Color(0xff2A2F37),
                          Color(0xff131518),
                        ],
                      ),
                      child: Container(
                        height: 14.0.h,
                        width: (Random().nextInt(60).w + 38).w.roundToDouble().w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        //divider
        Container(
          height: 75.h,
          color: Color(0xff23262D),
          width: 1.w,
        ),
        //section two
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //close
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff737A8B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Shimmer(
                      enabled: true,
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff131518),
                          Color(0xff2A2F37),
                          Color(0xff131518),
                        ],
                      ),
                      child: Container(
                        height: 14.0.h,
                        width: (Random().nextInt(60).w + 38).w.roundToDouble().w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                //low
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Low",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff737A8B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Shimmer(
                      enabled: true,
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff131518),
                          Color(0xff2A2F37),
                          Color(0xff131518),
                        ],
                      ),
                      child: Container(
                        height: 14.0.h,
                        width: (Random().nextInt(60).w + 38).w.roundToDouble().w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                //change
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff737A8B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Shimmer(
                          enabled: true,
                          direction: ShimmerDirection.ltr,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff131518),
                              Color(0xff2A2F37),
                              Color(0xff131518),
                            ],
                          ),
                          child: Container(
                            height: 14.0.h,
                            width: 14.0.w,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.0.w),
                        Shimmer(
                          enabled: true,
                          direction: ShimmerDirection.ltr,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff131518),
                              Color(0xff2A2F37),
                              Color(0xff131518),
                            ],
                          ),
                          child: Container(
                            height: 14.0.h,
                            width: 42.w,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
