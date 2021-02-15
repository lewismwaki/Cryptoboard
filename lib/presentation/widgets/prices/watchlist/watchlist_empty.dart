import 'package:cryptoboard/business_logic/blocs/prices_switcher/prices_switcher_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WatchListEmpty extends StatelessWidget {
  final PricesSwitcherBloc pricesSwitcherBloc;

  const WatchListEmpty({Key key, this.pricesSwitcherBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h, top: 15.h, right: 16.0.w, left: 16.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Watch Your Favorite Cryptocurrencies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Tap on the star next to a cryptocurrency to add it to your watchlist',
            style: TextStyle(
              color: Color(0xff646B80),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 30.0.h),
          Container(
            height: 48.0.h,
            width: 1.sw,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: MaterialButton(
              height: 48.0.h,
              minWidth: 1.sw,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              focusElevation: 0.0,
              elevation: 0.0,
              child: Text(
                'Exit Watchlist View',
                style: normalText.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              color: Color(0xff323546),
              onPressed: () {
                pricesSwitcherBloc..add(LoadAssetsList());
              },
            ),
          ),
        ],
      ),
    );
  }
}
