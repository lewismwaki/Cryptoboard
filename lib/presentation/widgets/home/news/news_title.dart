import 'package:cryptoboard/business_logic/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);
    final TabSwitcherBloc tabSwitcherBloc = BlocProvider.of<TabSwitcherBloc>(context);
    final BottomNavBarBloc bottomNavBarBloc = BlocProvider.of<BottomNavBarBloc>(context);
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
                    'News',
                    style: titleText,
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text("Breaking & Trending News", style: subTitle),
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
              bottomNavBarBloc..add(LoadDiscoverPage());
              tabSwitcherBloc..add(LoadLatestNews());
              newsBloc.state is NewsInitial ? BlocProvider.of<NewsBloc>(context).add(NewsRequested()) : null;
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
