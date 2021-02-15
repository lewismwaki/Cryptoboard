import 'package:cryptoboard/business_logic/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GainersLosersTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomNavBarBloc bottomNavBarBloc = BlocProvider.of<BottomNavBarBloc>(context);
    final TabSwitcherBloc tabSwitcherBloc = BlocProvider.of<TabSwitcherBloc>(context);
    final AssetsCubit assetsCubit = BlocProvider.of<AssetsCubit>(context);
    final SortCubit sortCubit = BlocProvider.of<SortCubit>(context);

    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 10.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Gainers & Losers',
                    style: titleText,
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text("Based on Top 100 Coins", style: subTitle),
            ],
          ),
          MaterialButton(
            padding: EdgeInsets.only(left: 8.w, right: 8.0.w),
            color: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Color(0xff070C1A),
            textColor: Color(0xff4878FF),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            onPressed: () {
              tabSwitcherBloc..add(LoadTopGainers());
              bottomNavBarBloc..add(LoadDiscoverPage());
              sortCubit.sortByPercentageChange();
              assetsCubit.state is! AssetsSortedByPercentageChangeDescending ? assetsCubit.sortAssetsByPercentageChangeDescending() : null;
            },
            minWidth: 0.0.w,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Text(
              'See All',
            ),
          ),
        ],
      ),
    );
  }
}
