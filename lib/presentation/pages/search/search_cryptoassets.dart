import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/screens/loading/home_assets_load_in_progress.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supercharged/supercharged.dart';

class SearchCryptoassets extends SearchDelegate {
  final HomeContentCubit homeContentCubit;

  SearchCryptoassets({this.homeContentCubit});

  @override
  String get searchFieldLabel => "Search";

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context).textTheme.headline6.copyWith(
                color: Color(0xff82899E),
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
        ),
        primaryColor: Colors.black,
        primaryTextTheme: TextTheme(
          caption: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        hintColor: Colors.white24,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
        primaryColorBrightness: Brightness.dark,
      );

  @override
  Widget buildLeading(BuildContext context) {
    return Icon(
      Icons.search,
      color: Color(0xff646B80),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 10.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
              width: 15.0,
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                padding: EdgeInsets.all(0.0),
                onPressed: () {
                  query = '';
                },
                icon: Icon(
                  Icons.cancel,
                  size: 20.0,
                  color: query.isEmpty ? Colors.black : Color(0xff646B80),
                ),
              ),
            ),
            SizedBox(width: 16.0.w),

            VerticalDivider(
              color: Color(0xff646B80),
              width: 1.0,
              indent: 7,
              endIndent: 7,
            ),

            SizedBox(width: 16.0.w),
            //see all
            MaterialButton(
              color: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                close(context, null);
              },
              minWidth: 0.0.w,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.all(0),
              textColor: Color(0xff4878FF),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xff4878FF),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 16.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Cryptoassets',
                        style: titleText.copyWith(fontSize: 16.0.sp),
                      ),
                      //title
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 16.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Cryptoassets',
                        style: titleText.copyWith(fontSize: 16.0.sp),
                      ),
                      //title
                    ],
                  ),
                ),
                BlocBuilder<HomeContentCubit, HomeContentState>(
                  cubit: homeContentCubit,
                  builder: (context, state) {
                    if (state is HomeContentLoadSuccess) {
                      final itemCount = (state.assetsClass.data
                              .where((element) => element.name.toLowerCase().contains(query) || element.symbol.toLowerCase().contains(query)))
                          .toList()
                          .length;

                      if (query.isEmpty) {
                        //all
                        return Container(
                          height: 1.sh,
                          child: ListView.separated(
                            itemCount: itemCount,
                            separatorBuilder: (context, int) => Divider(
                              height: 1,
                              color: Color(0xff646B80),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final assetClass = state.assetsClass.data;
                              final sortedByRankAscending = assetClass.sortedByNum((element) => double.parse(element.rank));
                              final asset = sortedByRankAscending[index];
                              final icon = asset.symbol.toLowerCase();

                              return Theme(
                                data: ThemeData(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 19,
                                    backgroundColor: Colors.black,
                                    child: Container(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        placeholder: (BuildContext, String) => ShimmerAvi(),
                                        imageUrl: 'https://icons.bitbot.tools/api/$icon/64x64',
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        asset.name,
                                        style: assetText.copyWith(fontSize: 13.0.sp),
                                      ),
                                      SizedBox(width: 4.0.h),
                                      Text(
                                        asset.symbol,
                                        style: initialsText,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      //searched
                      return Container(
                        height: 1.sh,
                        child: ListView.separated(
                          itemCount: itemCount,
                          separatorBuilder: (context, int) => Divider(
                            height: 1,
                            color: Color(0xff646B80),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final searchResults = (state.assetsClass.data
                                    .where((element) => element.name.toLowerCase().contains(query) || element.symbol.toLowerCase().contains(query)))
                                .toList();
                            final searchedAsset = searchResults[index];
                            final icon = searchedAsset.symbol.toLowerCase();
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.black,
                                child: Container(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    placeholder: (BuildContext, String) => ShimmerAvi(),
                                    imageUrl: 'https://icons.bitbot.tools/api/$icon/64x64',
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    searchedAsset.name,
                                    style: assetText.copyWith(fontSize: 13.0.sp),
                                  ),
                                  SizedBox(width: 4.0.h),
                                  Text(
                                    searchedAsset.symbol,
                                    style: initialsText,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else
                      return HomeAssetsLoadInProgress();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
