import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/coin_news/ripple_coin_news.dart';
import 'package:cryptoboard/presentation/screens/loading/news_load_in_progress_shimmer.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:cryptoboard/presentation/shared/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RippleSection extends StatefulWidget {
  @override
  _RippleSectionState createState() => _RippleSectionState();
}

class _RippleSectionState extends State<RippleSection> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);

    return BlocBuilder<NewsBloc, NewsState>(
      cubit: newsBloc,
      builder: (context, state) {
        final ChromeSafariBrowser browser = new MyChromeSafariBrowser(new WebViewContent());

        if (state is NewsLoadSuccess) {
          return Padding(
            padding: EdgeInsets.only(left: 16.0.w, bottom: 32.0.h, top: 32.0.h, right: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //details
                Container(
                  height: 372.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 20,
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index <= 2) {
                        final news = state.rippleNews.data[index];
                        final timestamp = news.publishedOn;
                        final newsUrl = news.url;

                        final publishedAt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
                        final publishedAgo = DateTime.now().difference(publishedAt);
                        final timeAgo = publishedAgo.inMinutes > 60 ? publishedAgo.inHours : publishedAgo.inMinutes;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 24.0.h),
                          child: GestureDetector(
                            onTap: () async {
                              await browser.open(url: Uri.parse(newsUrl));
                            },
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
                      } else
                        return Container();
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
                      'More Ripple News',
                      style: normalText.copyWith(fontSize: 13.sp),
                    ),
                    color: Color(0xff323546),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return RippleCoinNews(newsBloc: newsBloc);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is NewsLoadInProgress) {
          return NewsLoadInProgressShimmer();
        } else if (state is NewsLoadFailure) {
          return NewsLoadInProgressShimmer();
        } else {
          return null;
        }
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
