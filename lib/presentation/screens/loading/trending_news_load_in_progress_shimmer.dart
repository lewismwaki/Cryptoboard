import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsLoadInProgressShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.0.h,
      color: Colors.black,
      child: Swiper(
        itemCount: 1,
        indicatorLayout: PageIndicatorLayout.COLOR,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            size: 6,
            space: 5,
            color: Color(0xff323546),
            activeColor: Color(0xff646B80),
          ),
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 32.0.h),
            child: Shimmer(
              enabled: true,
              direction: ShimmerDirection.ltr,
              gradient: LinearGradient(
                // begin: Alignment.center,
                colors: [
                  Color(0xff131518),
                  Color(0xff2A2F37),
                  Color(0xff131518),
                ],
              ),
              child: Container(
                height: 350.h,
                width: 382.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.topCenter,
                  children: [
                    //image
                    Container(
                      height: 200.h,
                      color: Colors.black,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                    ),

                    //title
                    Positioned(
                      top: 200.h,
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 266.w,
                              height: 15.h,
                              color: Colors.black,
                            ),
                            SizedBox(height: 5.0.h),
                            Container(
                              width: (Random().nextInt(200).w + 10).w.roundToDouble().w,
                              height: 15.h,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),

                    //author and date
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0.w, bottom: 16.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //publisher
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.black,
                              child: Container(
                                alignment: Alignment.center,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),

                            SizedBox(width: 5.0.w),

                            //time
                            Container(
                              width: (Random().nextInt(90).w + 60).w.roundToDouble().w,
                              height: 12.h,
                              color: Colors.black,
                            ),
                          ],
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
    );
  }
}
