import 'package:cryptoboard/business_logic/blocs/network/network_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/latest_news_page.dart';
import 'package:cryptoboard/presentation/widgets/discover/recently_added_page/recently_added_page.dart';
import 'package:cryptoboard/presentation/widgets/discover/top_gainers_page/top_gainers_page.dart';
import 'package:cryptoboard/presentation/widgets/discover/top_losers_page/top_losers_page.dart';
import 'package:cryptoboard/presentation/widgets/discover_filter/latest_news.dart';
import 'package:cryptoboard/presentation/widgets/discover_filter/recently_added.dart';
import 'package:cryptoboard/presentation/widgets/discover_filter/top_gainers.dart';
import 'package:cryptoboard/presentation/widgets/discover_filter/top_losers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TabSwitcherBloc tabSwitcherBloc = BlocProvider.of<TabSwitcherBloc>(context);
    return BlocBuilder<TabSwitcherBloc, TabSwitcherState>(
      cubit: tabSwitcherBloc,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: BlocBuilder<NetworkBloc, NetworkState>(builder: (context, networkState) {
              return CustomScrollView(
                slivers: [
                  // appbar
                  SliverAppBar(
                    brightness: Brightness.dark,
                    backgroundColor: Colors.black,
                    title: Text('Discover', style: appBarText),
                    floating: true,
                    pinned: false,
                    bottom: PreferredSize(
                      preferredSize: Size(1.sw, 40.h),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0.h),
                        child: Container(
                          height: 30.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              LatestNews(),
                              SizedBox(width: 8.w),
                              TopGainers(),
                              SizedBox(width: 8.w),
                              TopLosers(),
                              SizedBox(width: 8.w),
                              RecentlyAdded(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // body
                  state is LatestNewsLoaded
                      ? LatestNewsPage()
                      : state is TopGainersLoaded
                          ? TopGainersPage()
                          : state is TopLosersLoaded
                              ? TopLosersPage()
                              : state is RecentlyAddedLoaded
                                  ? RecentlyAddedPage()
                                  : null
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
