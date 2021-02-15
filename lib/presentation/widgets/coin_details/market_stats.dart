import 'package:cryptoboard/business_logic/cubits/chart/chart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketStats extends StatelessWidget {
  final ChartCubit chartCubit;
  final String formattedMarketCap;
  final String formattedCircSupply;
  final String rank;
  final String formattedMaxSupply;
  final String formattedVolume24h;
  const MarketStats({
    Key key,
    this.chartCubit,
    this.formattedMarketCap,
    this.formattedCircSupply,
    this.formattedMaxSupply,
    this.formattedVolume24h,
    this.rank,
  }) : super(key: key);
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
                    Text(
                      formattedMarketCap,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                //circulating
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
                    Text(
                      formattedCircSupply,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                    Text(
                      rank,
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
                    Text(
                      formattedVolume24h,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                    Text(
                      formattedMaxSupply,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                //roi
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
                        // SizedBox(
                        //   height: 17.0.h,
                        //   width: 17.0.w,
                        //   child: Icon(
                        //     Icons.arrow_drop_up,
                        //     color: Color(0xff00D7A3),
                        //   ),
                        // ),
                        Text(
                          '—',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        SizedBox(width: 4.0.w),
                        Text(
                          'TBC',
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
