import 'package:cryptoboard/business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopLosers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final assetsCubit = BlocProvider.of<AssetsCubit>(context);
    final SortCubit sortCubit = BlocProvider.of<SortCubit>(context);

    final TabSwitcherBloc tabSwitcherBloc = BlocProvider.of<TabSwitcherBloc>(context);
    return BlocBuilder<TabSwitcherBloc, TabSwitcherState>(
      cubit: tabSwitcherBloc,
      builder: (context, state) {
        return MaterialButton(
          height: 40.0.h,
          onPressed: () {
            sortCubit.sortByPercentageChange();
            assetsCubit.sortAssetsByPercentageChangeAscending();
            tabSwitcherBloc..add(LoadTopLosers());
          },
          minWidth: 0.0.w,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: state is TopLosersLoaded ? Colors.white : Color(0xff23262D),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Text(
            'Top Losers',
            style: normalText.copyWith(
              color: state is TopLosersLoaded ? Colors.black : Colors.white,
            ),
          ),
        );
      },
    );
  }
}
