import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OneDayPriceDetails extends StatelessWidget {
  final String formattedOpen;
  final String formattedOpenSmall;
  final String formattedHigh;
  final String formattedHighSmall;
  final String formattedLow;
  final String formattedLowSmall;
  final String formattedClose;
  final String formattedCloseSmall;
  final String formattedAverage;
  final String formattedAverageSmall;
  final String oneDayOpen;
  final String oneDayClose;
  final String oneDayHigh;
  final double move;
  final double low;
  final double high;
  final double close;
  final double open;
  final String changePercent24Hr;
  final String oneDayLow;
  const OneDayPriceDetails({
    Key key,
    this.changePercent24Hr,
    this.formattedOpen,
    this.formattedHigh,
    this.formattedLow,
    this.formattedClose,
    this.oneDayOpen,
    this.oneDayClose,
    this.oneDayHigh,
    this.oneDayLow,
    this.move,
    this.formattedOpenSmall,
    this.formattedHighSmall,
    this.formattedLowSmall,
    this.formattedCloseSmall,
    this.low,
    this.high,
    this.close,
    this.open,
    this.formattedAverage,
    this.formattedAverageSmall,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final average = ((open + high) / 2);

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
                    Text(
                      open > 1 ? formattedOpen : formattedOpenSmall,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                    Text(
                      high > 1 ? formattedHigh : formattedHighSmall,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                    Text(
                      average > 1 ? formattedAverage : formattedAverageSmall,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                    Text(
                      close > 1 ? formattedClose : formattedCloseSmall,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                    Text(
                      low > 1 ? formattedLow : formattedLowSmall,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                        move > 0.0001
                            ? SizedBox(
                                height: 17.0.h,
                                width: 17.0.w,
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  color: Color(0xff00D7A3),
                                ),
                              )
                            : SizedBox(
                                height: 17.0.h,
                                width: 17.0.w,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xffED376A),
                                ),
                              ),
                        SizedBox(width: 4.0.w),
                        Text(
                          changePercent24Hr.length == 18
                              ? changePercent24Hr.replaceRange(4, null, '') + "%"
                              : changePercent24Hr.length == 19
                                  ? changePercent24Hr.replaceRange(5, null, '') + "%"
                                  : changePercent24Hr.length == 20
                                      ? changePercent24Hr.replaceRange(6, null, '') + "%"
                                      : '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
