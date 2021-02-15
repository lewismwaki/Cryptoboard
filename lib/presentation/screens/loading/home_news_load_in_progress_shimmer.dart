import 'dart:math';

import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeNewsLoadInProgressShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      enabled: true,
      direction: ShimmerDirection.ltr,
      gradient: LinearGradient(
        colors: [
          Color(0xff131518),
          Color(0xff2A2F37),
          Color(0xff131518),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0.w, bottom: 32.0.w, top: 32.0.w, right: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 638.h,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24.0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //image
                        Container(
                          height: 100.0.h,
                          width: 100.0.w,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        //title
                        Padding(
                          padding: EdgeInsets.only(left: 16.0.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6.0.h),
                              Container(
                                width: 266.w,
                                height: 15.h,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4.0.r),
                                ),
                              ),
                              SizedBox(height: 5.0.h),
                              Container(
                                width: (Random().nextInt(200).w + 10).w.roundToDouble().w,
                                height: 15.h,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4.0.r),
                                ),
                              ),
                              SizedBox(height: 16.0.h),
                              Row(
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

                                  SizedBox(width: 5.0.h),

                                  //time
                                  Container(
                                    width: (Random().nextInt(90).w + 60).w.roundToDouble().w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4.0.r),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            //details

            //more news

            Container(
              height: 48.0,
              width: 1.sw,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: MaterialButton(
                height: 48.0,
                minWidth: 1.sw,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                focusElevation: 0.0,
                elevation: 0.0,
                child: Text(
                  'More Bitcoin News',
                  style: normalText.copyWith(fontSize: 11.sp),
                ),
                color: Color(0xff323546),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
