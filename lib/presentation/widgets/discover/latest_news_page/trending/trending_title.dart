import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/coin_news/trending_coin_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);
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
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 16,
                    child: Text(
                      '🔥',
                    ),
                  ),

                  // SizedBox(width: 5.w),
                  Text(
                    ' Trending',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text("Popular & Breaking News", style: subTitle),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return TrendingCoinNews(newsBloc: newsBloc);
                  },
                ),
              );
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
