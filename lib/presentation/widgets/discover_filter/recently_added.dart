import 'package:cryptoboard/business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentlyAdded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TabSwitcherBloc tabSwitcherBloc = BlocProvider.of<TabSwitcherBloc>(context);
    return BlocBuilder<TabSwitcherBloc, TabSwitcherState>(
      cubit: tabSwitcherBloc,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(right: 16.0.w),
          child: MaterialButton(
            height: 40.0.h,
            onPressed: () {
              tabSwitcherBloc..add(LoadRecentlyAdded());
            },
            minWidth: 0.0.w,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: state is RecentlyAddedLoaded ? Colors.white : Color(0xff23262D),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Text(
              'Recently Added',
              style: normalText.copyWith(
                color: state is RecentlyAddedLoaded ? Colors.black : Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
