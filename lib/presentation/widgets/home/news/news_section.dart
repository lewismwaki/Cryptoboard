import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/screens/loading/home_news_load_in_progress_shimmer.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:cryptoboard/presentation/shared/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NewsSection extends StatefulWidget {
  @override
  _NewsSectionState createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);
    final BottomNavBarBloc bottomNavBarBloc = BlocProvider.of<BottomNavBarBloc>(context);
    final HomeContentCubit homeContentCubit = BlocProvider.of<HomeContentCubit>(context);
    return BlocBuilder<HomeContentCubit, HomeContentState>(
      cubit: homeContentCubit,
      builder: (BuildContext context, state) {
        final ChromeSafariBrowser browser = new MyChromeSafariBrowser(new WebViewContent());

        if (state is HomeContentLoadSuccess) {
          return Padding(
            padding: EdgeInsets.only(left: 16.0.w, bottom: 32.0.h, top: 32.0.h, right: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //details
                Container(
                  height: 638.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    cacheExtent: 5,
                    itemCount: 5,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final news = state.trendingNews.data[index];
                      final timestamp = news.publishedOn;
                      final newsUrl = news.url;
                      final publishedAt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
                      final publishedAgo = DateTime.now().difference(publishedAt);
                      final timeAgo = publishedAgo.inMinutes > 60 ? publishedAgo.inHours : publishedAgo.inMinutes;
                      return GestureDetector(
                        onTap: () async {
                          await browser.open(url: newsUrl);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 24.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //image
                              Container(
                                height: 100.0.h,
                                width: 100.0.w,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.h),
                                ),
                                child: CachedNetworkImage(
                                  height: 100.h,
                                  width: double.maxFinite,
                                  filterQuality: FilterQuality.high,
                                  imageUrl: news.imageurl,
                                  fit: BoxFit.cover,
                                  placeholder: (BuildContext, String) => ShimmerBitcoinNewsImage(),
                                  alignment: Alignment.center,
                                ),
                              ),

                              //title
                              Padding(
                                padding: EdgeInsets.only(left: 16.0.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 266.w,
                                      child: Text(
                                        news.title,
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: newsTitle,
                                      ),
                                    ),
                                    SizedBox(height: 16.0.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        //publisher
                                        CircleAvatar(
                                          radius: 13.h,
                                          backgroundColor: Colors.black,
                                          child: Container(
                                            alignment: Alignment.center,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              placeholder: (BuildContext, String) => ShimmerAvi(),
                                              imageUrl: news.sourceInfo.img,
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 5.0.w),

                                        //time
                                        Text(
                                          publishedAgo.inMinutes > 60
                                              ? news.sourceInfo.name + " • " + timeAgo.toString() + 'h' + " ago"
                                              : news.sourceInfo.name + " • " + timeAgo.toString() + 'm' + " ago",
                                          style: subTitle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //more news
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
                      'More News',
                      style: normalText.copyWith(fontSize: 13.sp),
                    ),
                    color: Color(0xff323546),
                    onPressed: () {
                      bottomNavBarBloc..add(LoadDiscoverPage());
                      newsBloc.state is NewsInitial ? BlocProvider.of<NewsBloc>(context).add(NewsRequested()) : null;
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is HomeContentLoadInProgress) {
          return HomeNewsLoadInProgressShimmer();
        } else
          return Container(
            height: 200,
            color: Colors.black,
          );
      },
    );
  }

  Widget ShimmerBitcoinNewsImage() {
    return Shimmer(
      enabled: true,
      direction: ShimmerDirection.ltr,
      gradient: LinearGradient(
        colors: [
          Color(0xff131518),
          Color(0xff2A2F37),
        ],
      ),
      child: Container(
        height: 56.h,
        width: double.maxFinite,
        color: Colors.red,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
