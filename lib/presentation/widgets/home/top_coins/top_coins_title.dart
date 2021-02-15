import 'package:cryptoboard/business_logic/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopCoinsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AssetsCubit assetsCubit = BlocProvider.of<AssetsCubit>(context);
    final SortCubit sortCubit = BlocProvider.of<SortCubit>(context);

    final BottomNavBarBloc bottomNavBarBloc = BlocProvider.of<BottomNavBarBloc>(context);

    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 10.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Top Coins',
                    style: titleText,
                  ),
                ],
              ),
            ],
          ),

          //see all
          MaterialButton(
            padding: EdgeInsets.only(left: 8.w, right: 8.0.w),
            color: Colors.transparent,
            textColor: Color(0xff4878FF),
            splashColor: Colors.transparent,
            highlightColor: Color(0xff070C1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            onPressed: () {
              sortCubit.sortByRank();
              bottomNavBarBloc..add(LoadPricesPage());
              assetsCubit.state is! AssetsSortedByRankAscending ? assetsCubit.sortAssetsByRankAscending() : null;
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
