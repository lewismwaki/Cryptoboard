import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeAssetsLoadInProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
      child: Container(
        height: 180.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: index == 0
                  ? EdgeInsets.only(left: 16.0.w, right: 8.w)
                  : index == 14
                      ? EdgeInsets.only(right: 16.0.w)
                      : EdgeInsets.only(right: 8.0.w),
              child: Container(
                height: 160.h,
                width: 145.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Color(0xff222531),
                  borderRadius: BorderRadius.circular(18.w),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer(
                        enabled: true,
                        direction: ShimmerDirection.ltr,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff363A48),
                            Color(0xff303441),
                            Color(0xff363A48),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 19,
                          backgroundColor: Colors.black,
                          child: Container(
                            alignment: Alignment.center,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer(
                            enabled: true,
                            direction: ShimmerDirection.ltr,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff363A48),
                                Color(0xff303441),
                                Color(0xff363A48),
                              ],
                            ),
                            child: Container(
                              width: (Random().nextInt(60).w + 38).w.roundToDouble().w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                color: Color(0xff303441),
                                borderRadius: BorderRadius.circular(4.0.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0.h),
                          Shimmer(
                            enabled: true,
                            direction: ShimmerDirection.ltr,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff363A48),
                                Color(0xff303441),
                                Color(0xff363A48),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff303441),
                                borderRadius: BorderRadius.circular(4.0.r),
                              ),
                              width: (Random().nextInt(90).w + 16).w.roundToDouble().w,
                              height: 10.h,
                            ),
                          ),
                        ],
                      ),

                      //up/down
                      Shimmer(
                        enabled: true,
                        direction: ShimmerDirection.ltr,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff363A48),
                            Color(0xff303441),
                            Color(0xff363A48),
                          ],
                        ),
                        child: Container(
                          width: (Random().nextInt(50).w + 46).w.roundToDouble().w,
                          height: 13.h,
                          decoration: BoxDecoration(
                            color: Color(0xff303441),
                            borderRadius: BorderRadius.circular(4.0.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
