import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TabSwitcherBloc tabSwitcherBloc = BlocProvider.of<TabSwitcherBloc>(context);
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);
    return BlocBuilder<TabSwitcherBloc, TabSwitcherState>(
      cubit: tabSwitcherBloc,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: MaterialButton(
            height: 40.0.h,
            onPressed: () {
              tabSwitcherBloc..add(LoadLatestNews());
              newsBloc.add(NewsRequested());
            },
            minWidth: 0.0.w,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: state is LatestNewsLoaded ? Colors.white : Color(0xff23262D),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Text(
              'Latest News',
              style: normalText.copyWith(
                color: state is LatestNewsLoaded ? Colors.black : Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
