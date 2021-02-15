import 'dart:ui';

import 'package:cryptoboard/business_logic/cubits/all_coins/all_coins_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionSection extends StatelessWidget {
  final String symbol;
  final String name;
  final String coinDescription;
  final String coinUrl;
  final String coinProofType;
  final String coinAlgorithm;
  final AllCoinsCubit allCoinsCubit;

  const DescriptionSection({
    Key key,
    this.symbol,
    this.name,
    this.allCoinsCubit,
    this.coinDescription,
    this.coinUrl,
    this.coinProofType,
    this.coinAlgorithm,
  }) : super(key: key);
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

          //question
          Text(
            'What Is $name (${symbol.toUpperCase()})?',
            style: appBarText.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 32.h),

          //desc
          ReadMoreText(
            coinDescription,
            trimLines: 4,
            colorClickableText: Color(0xff4262DB),
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Read less',
            moreStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: Color(0xff4262DB),
            ),
            textAlign: TextAlign.left,
            style: TextStyle(
              height: 1.75.h,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
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
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                constraints: BoxConstraints(
                  minHeight: 22.0.h,
                  maxHeight: 22.0.h,
                  minWidth: 0.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  color: Colors.black,
                  border: Border.all(
                    color: Color(0xff41444A),
                    width: 1.5.w,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Text(
                  coinAlgorithm,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                alignment: Alignment.center,
                height: 22.h,
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                constraints: BoxConstraints(
                  minHeight: 22.0.h,
                  maxHeight: 22.0.h,
                  minWidth: 0.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  color: Colors.black,
                  border: Border.all(
                    color: Color(0xff41444A),
                    width: 1.5.w,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Text(
                  coinProofType,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                    color: Colors.white,
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
            onTap: () async {
              if (await canLaunch("https://www.coinmarketcap.com/currencies/$name")) {
                await launch("https://www.coinmarketcap.com/currencies/$name");
              } else {
                throw 'Could not launch "https://www.coinmarketcap.com/currencies/$name"';
              }
            },
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
