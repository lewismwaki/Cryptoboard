import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MarketStatsLoadInProgress extends StatelessWidget {
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
                //mkt cap
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Mkt Cap",
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

                //circ supply
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Circ Supply",
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

                //rank
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Rank",
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
                //24h vol
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "24h Vol",
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

                //max supply
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Max Supply",
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

                //ROI
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "ROI",
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
