import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:cryptoboard/presentation/screens/loading/trending_news_load_in_progress_shimmer.dart';
import 'package:cryptoboard/presentation/shared/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shimmer/shimmer.dart';

class TrendingSection extends StatefulWidget {
  @override
  _TrendingSectionState createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final ChromeSafariBrowser browser = new MyChromeSafariBrowser(new WebViewContent());
        if (state is NewsLoadSuccess) {
          return Container(
            height: 360.0.h,
            color: Colors.black,
            child: Swiper(
              loop: true,
              outer: false,
              itemCount: 6,
              indicatorLayout: PageIndicatorLayout.COLOR,
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  size: 6,
                  space: 5,
                  color: Color(0xff323546),
                  activeColor: Color(0xff646B80),
                ),
              ),
              itemBuilder: (context, index) {
                final news = state.trendingNews.data[index];
                final timestamp = news.publishedOn;
                final newsUrl = news.url;
                final publishedAt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
                final publishedAgo = DateTime.now().difference(publishedAt);
                final timeAgo = publishedAgo.inMinutes > 60 ? publishedAgo.inHours : publishedAgo.inMinutes;

                return Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 32.0.h),
                  child: GestureDetector(
                    onTap: () async {
                      await browser.open(url: newsUrl);
                    },
                    child: Container(
                      height: 350.h,
                      width: 382.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff222531),
                      ),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.topCenter,
                        children: [
                          //image
                          CachedNetworkImage(
                            height: 200.h,
                            width: double.maxFinite,
                            filterQuality: FilterQuality.high,
                            imageUrl: news.imageurl,
                            fit: BoxFit.cover,
                            placeholder: (BuildContext, String) => ShimmerTrendingNewsImage(),
                            alignment: Alignment.center,
                          ),

                          //title
                          Positioned(
                            top: 200.h,
                            left: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                              child: Text(
                                news.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: newsTitle,
                              ),
                            ),
                          ),

                          //author and date
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0.w, bottom: 16.0.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //publisher
                                  CircleAvatar(
                                    radius: 13,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is NewsLoadInProgress) {
          return TrendingNewsLoadInProgressShimmer();
        } else if (state is NewsLoadFailure) {
          return TrendingNewsLoadInProgressShimmer();
        } else
          return null;
      },
    );
  }

  Widget ShimmerTrendingNewsImage() {
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
        height: 210.h,
        width: 1.sw,
        color: Colors.red,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
