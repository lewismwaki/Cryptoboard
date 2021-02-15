import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AssetsLoadInProgressShimmer extends StatelessWidget {
  final int index;
  AssetsLoadInProgressShimmer({Key key, this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h, top: 15.h, right: 16.0.w, left: 16.0.w),
      child: Container(
        height: 44.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //avi
            Row(
              children: [
                Shimmer(
                  enabled: true,
                  direction: ShimmerDirection.ltr,
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    colors: [
                      Color(0xff131518),
                      Color(0xff131518),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 19,
                  ),
                ),

                //first section
                SizedBox(width: 8.0.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //asset
                        Shimmer(
                          enabled: true,
                          direction: ShimmerDirection.ltr,
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            colors: [
                              Color(0xff131518),
                              Color(0xff131518),
                            ],
                          ),
                          child: Container(
                            height: 16.h,
                            width: (Random().nextInt(80).w + 45).w.roundToDouble().w,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4.0.r),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //rank
                        Shimmer(
                          enabled: true,
                          direction: ShimmerDirection.ltr,
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            colors: [
                              Color(0xff131518),
                              Color(0xff131518),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4.0.r),
                            ),
                            height: 12.h,
                            width: (Random().nextInt(80).w + 30).w.roundToDouble().w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            //chart

            //last section
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //price
                    Shimmer(
                      enabled: true,
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff131518),
                          Color(0xff131518),
                        ],
                      ),
                      child: Container(
                        height: 16.h,
                        width: (Random().nextInt(70).w + 40).w.roundToDouble().w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.0.r),
                        ),
                      ),
                    ),

                    //market cap
                    Shimmer(
                      enabled: true,
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff131518),
                          Color(0xff131518),
                        ],
                      ),
                      child: Container(
                        height: 12.h,
                        width: (Random().nextInt(90).w + 60).w.roundToDouble().w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.0.r),
                        ),
                      ),
                    ), //favourite icon
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 14.0.w),
                    Shimmer(
                      enabled: true,
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff131518),
                          Color(0xff131518),
                          // Color(0xff2D3643),
                        ],
                      ),
                      child: Container(
                        height: 18.h,
                        width: 18.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100.0.r),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
