import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/range_switcher/range_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/24h_chart/chart24h_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/all_coins/all_coins_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/chart/chart_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/coin_details/coin_details.dart';
import 'package:cryptoboard/presentation/screens/loading/home_assets_load_in_progress.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

class SearchPage extends SearchDelegate {
  final HomeContentCubit homeContentCubit;

  SearchPage({this.homeContentCubit});
  @override
  String get searchFieldLabel => "Search";

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        brightness: Brightness.light,
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
        primaryColorBrightness: Brightness.light,
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
                  color: query.isNotEmpty ? Color(0xff646B80) : Colors.black,
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
    final RangeSwitcherBloc rangeSwitcherBloc = BlocProvider.of<RangeSwitcherBloc>(context);
    final AllCoinsCubit allCoinsCubit = BlocProvider.of<AllCoinsCubit>(context);
    final ChartCubit chartCubit = BlocProvider.of<ChartCubit>(context);
    final Chart24hCubit chart24hCubit = BlocProvider.of<Chart24hCubit>(context);
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
                            final double move = double.parse(searchedAsset.changePercent24Hr);
                            final double marketCapUsd = double.parse(searchedAsset.marketCapUsd);
                            final double priceUsd = double.parse(searchedAsset.priceUsd);
                            final formattedMarketCap =
                                NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
                            final formattedPriceMore = NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(priceUsd);
                            final formattedPriceLess = NumberFormat.currency(decimalDigits: 8, symbol: '\$').format(priceUsd);
                            final name = searchedAsset.name;
                            final symbol = searchedAsset.symbol;
                            final rank = searchedAsset.rank;
                            final changePercent24Hr = searchedAsset.changePercent24Hr;
                            final String priceUsdString = searchedAsset.priceUsd;
                            final double volume24h = double.parse(searchedAsset.volumeUsd24Hr);
                            final double circSupply = double.parse(searchedAsset.supply);

                            final formattedVolume24h =
                                NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(volume24h);
                            final formattedCircSupply =
                                NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(circSupply);
                            final formattedMaxSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$')
                                .format(searchedAsset.maxSupply == null ? 1 : double.parse(searchedAsset.maxSupply));
                            return ListTile(
                              onTap: () {
                                chartCubit.loadPastDayChart(symbol: symbol);
                                chart24hCubit.loadPastDayChart(symbol: symbol);
                                rangeSwitcherBloc..add(LoadPastDay());
                                allCoinsCubit.loadCoinData();

                                //description section
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return CoinDetails(
                                        // rangeSwitcherBloc: rangeSwitcherBloc,
                                        move: move,
                                        index: index,
                                        changePercent24Hr: changePercent24Hr,
                                        priceUsdString: priceUsdString,
                                        icon: icon,
                                        name: name,
                                        symbol: symbol,
                                        rank: rank,
                                        // chartCubit: chartCubit,
                                        formattedPriceLess: formattedPriceLess,
                                        formattedPriceMore: formattedPriceMore,
                                        formattedMarketCap: formattedMarketCap,
                                        formattedVolume24h: formattedVolume24h,
                                        formattedCircSupply: formattedCircSupply,
                                        formattedMaxSupply: formattedMaxSupply,
                                        priceUsd: priceUsd,
                                      );
                                    },
                                  ),
                                );
                              },
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

  @override
  Widget buildSuggestions(BuildContext context) {
    final RangeSwitcherBloc rangeSwitcherBloc = BlocProvider.of<RangeSwitcherBloc>(context);
    final AllCoinsCubit allCoinsCubit = BlocProvider.of<AllCoinsCubit>(context);
    final ChartCubit chartCubit = BlocProvider.of<ChartCubit>(context);
    final Chart24hCubit chart24hCubit = BlocProvider.of<Chart24hCubit>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //trending title
                query.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 16.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Trending',
                              style: titleText.copyWith(fontSize: 16.0.sp),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 13,
                              child: Text(
                                '🔥',
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
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

                //trending assets & searched assets
                BlocBuilder<HomeContentCubit, HomeContentState>(
                  builder: (context, state) {
                    if (state is HomeContentLoadSuccess) {
                      if (query.isEmpty) {
                        //trending
                        return Padding(
                          padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
                          child: Container(
                            height: 132.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 15,
                              itemBuilder: (context, index) {
                                final assetClass = state.assetsClass.data;
                                final sortedByRankAscending = assetClass.sortedByNum((element) => double.parse(element.rank));
                                final asset = sortedByRankAscending[index];
                                final double move = double.parse(asset.changePercent24Hr);
                                final double marketCapUsd = double.parse(asset.marketCapUsd);
                                final double priceUsd = double.parse(asset.priceUsd);
                                final icon = asset.symbol.toLowerCase();
                                final formattedMarketCap =
                                    NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
                                final formattedPriceMore = NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(priceUsd);
                                final formattedPriceLess = NumberFormat.currency(decimalDigits: 8, symbol: '\$').format(priceUsd);
                                final name = asset.name;
                                final symbol = asset.symbol;
                                final rank = asset.rank;
                                final changePercent24Hr = asset.changePercent24Hr;
                                final String priceUsdString = asset.priceUsd;
                                final double volume24h = double.parse(asset.volumeUsd24Hr);
                                final double circSupply = double.parse(asset.supply);
                                final formattedVolume24h =
                                    NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(volume24h);
                                final formattedCircSupply =
                                    NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(circSupply);
                                final formattedMaxSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$')
                                    .format(asset.maxSupply == null ? 1 : double.parse(asset.maxSupply));
                                // if (state.trendingNews.data[index].body.contains(state.assetsClass.data[index].name) == true) {
                                final trendingAsset = state.assetsClass.data[index];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    chartCubit.loadPastDayChart(symbol: symbol);
                                    chart24hCubit.loadPastDayChart(symbol: symbol);
                                    rangeSwitcherBloc..add(LoadPastDay());
                                    allCoinsCubit.loadCoinData();

                                    //description section
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return CoinDetails(
                                            // rangeSwitcherBloc: rangeSwitcherBloc,
                                            move: move,
                                            index: index,
                                            changePercent24Hr: changePercent24Hr,
                                            priceUsdString: priceUsdString,
                                            icon: icon,
                                            name: name,
                                            symbol: symbol,
                                            rank: rank,
                                            // chartCubit: chartCubit,
                                            formattedPriceLess: formattedPriceLess,
                                            formattedPriceMore: formattedPriceMore,
                                            formattedMarketCap: formattedMarketCap,
                                            formattedVolume24h: formattedVolume24h,
                                            formattedCircSupply: formattedCircSupply,
                                            formattedMaxSupply: formattedMaxSupply,
                                            priceUsd: priceUsd,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: index == 0
                                        ? EdgeInsets.only(left: 16.0.w, right: 8.w)
                                        : index == 14
                                            ? EdgeInsets.only(right: 16.0.w)
                                            : EdgeInsets.only(right: 8.0.w),
                                    child: Container(
                                      height: 132.h,
                                      width: 132.w,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: Color(0xff222531),
                                        borderRadius: BorderRadius.circular(18.w),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
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
                                            SizedBox(height: 5.0.h),
                                            // SizedBox(height: 8.0.h),
                                            Text(trendingAsset.name, style: assetText),

                                            //up/down
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  trendingAsset.symbol,
                                                  style: initialsText,
                                                ),
                                                SizedBox(width: 4.0.w),
                                                Container(
                                                  constraints: BoxConstraints(
                                                    minHeight: 14.h,
                                                    maxHeight: 14.h,
                                                    minWidth: 18.w,
                                                    maxWidth: 18.w,
                                                  ),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    color: Color(0xff323546),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      trendingAsset.rank,
                                                      style: rankText,
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(width: 4.0.w),

                                                //percentage change
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }

                      //searched
                      return Container(
                        height: 1.sh,
                        child: ListView.separated(
                          itemCount: (state.assetsClass.data
                                  .where((element) => element.name.toLowerCase().contains(query) || element.symbol.toLowerCase().contains(query)))
                              .toList()
                              .length,
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
                            final double move = double.parse(searchedAsset.changePercent24Hr);
                            final double marketCapUsd = double.parse(searchedAsset.marketCapUsd);
                            final double priceUsd = double.parse(searchedAsset.priceUsd);
                            final formattedMarketCap =
                                NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
                            final formattedPriceMore = NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(priceUsd);
                            final formattedPriceLess = NumberFormat.currency(decimalDigits: 8, symbol: '\$').format(priceUsd);
                            final name = searchedAsset.name;
                            final symbol = searchedAsset.symbol;
                            final rank = searchedAsset.rank;
                            final changePercent24Hr = searchedAsset.changePercent24Hr;
                            final String priceUsdString = searchedAsset.priceUsd;
                            final double volume24h = double.parse(searchedAsset.volumeUsd24Hr);
                            final double circSupply = double.parse(searchedAsset.supply);

                            final formattedVolume24h =
                                NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(volume24h);
                            final formattedCircSupply =
                                NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(circSupply);
                            final formattedMaxSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$')
                                .format(searchedAsset.maxSupply == null ? 1 : double.parse(searchedAsset.maxSupply));

                            return ListTile(
                              focusColor: Colors.transparent,
                              onTap: () {
                                chartCubit.loadPastDayChart(symbol: symbol);
                                chart24hCubit.loadPastDayChart(symbol: symbol);
                                rangeSwitcherBloc..add(LoadPastDay());
                                allCoinsCubit.loadCoinData();

                                //description section
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return CoinDetails(
                                        // rangeSwitcherBloc: rangeSwitcherBloc,
                                        move: move,
                                        index: index,
                                        changePercent24Hr: changePercent24Hr,
                                        priceUsdString: priceUsdString,
                                        icon: icon,
                                        name: name,
                                        symbol: symbol,
                                        rank: rank,
                                        // chartCubit: chartCubit,
                                        formattedPriceLess: formattedPriceLess,
                                        formattedPriceMore: formattedPriceMore,
                                        formattedMarketCap: formattedMarketCap,
                                        formattedVolume24h: formattedVolume24h,
                                        formattedCircSupply: formattedCircSupply,
                                        formattedMaxSupply: formattedMaxSupply,
                                        priceUsd: priceUsd,
                                      );
                                    },
                                  ),
                                );
                              },
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

                //top movers title
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Top Movers',
                                style: titleText.copyWith(fontSize: 16.0.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //top movers
                BlocBuilder<HomeContentCubit, HomeContentState>(
                  cubit: homeContentCubit,
                  builder: (BuildContext context, state) {
                    if (state is HomeContentLoadSuccess) {
                      return Padding(
                        padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
                        child: Container(
                          height: 180.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              final assetClass = state.assetsClass.data;
                              final sortedByPercentageChangeDescending =
                                  assetClass.sortedByNum((element) => double.parse(element.changePercent24Hr)).reversed.toList();
                              final reversedAsset = sortedByPercentageChangeDescending[index];
                              final double move = double.parse(reversedAsset.changePercent24Hr);
                              final double priceUsd = double.parse(reversedAsset.priceUsd);
                              final double marketCapUsd = double.parse(reversedAsset.marketCapUsd);
                              final icon = reversedAsset.symbol.toLowerCase();
                              final _formattedPriceMore = NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(priceUsd);
                              final _formattedPriceLess = NumberFormat.currency(decimalDigits: 8, symbol: '\$').format(priceUsd);
                              final name = reversedAsset.name;
                              final symbol = reversedAsset.symbol;
                              final rank = reversedAsset.rank;
                              final changePercent24Hr = reversedAsset.changePercent24Hr;
                              final String priceUsdString = reversedAsset.priceUsd;
                              final double volume24h = double.parse(reversedAsset.volumeUsd24Hr);
                              final double circSupply = double.parse(reversedAsset.supply);

                              final formattedPriceMore = NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(priceUsd);
                              final formattedPriceLess = NumberFormat.currency(decimalDigits: 8, symbol: '\$').format(priceUsd);
                              final formattedMarketCap =
                                  NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
                              final formattedVolume24h =
                                  NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(volume24h);
                              final formattedCircSupply =
                                  NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(circSupply);
                              final formattedMaxSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$')
                                  .format(reversedAsset.maxSupply == null ? 1 : double.parse(reversedAsset.maxSupply));

                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () {
                                  chartCubit.loadPastDayChart(symbol: symbol);
                                  chart24hCubit.loadPastDayChart(symbol: symbol);
                                  rangeSwitcherBloc..add(LoadPastDay());
                                  allCoinsCubit.loadCoinData();

                                  //description section
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return CoinDetails(
                                          // rangeSwitcherBloc: rangeSwitcherBloc,
                                          move: move,
                                          index: index,
                                          changePercent24Hr: changePercent24Hr,
                                          priceUsdString: priceUsdString,
                                          icon: icon,
                                          name: name,
                                          symbol: symbol,
                                          rank: rank,
                                          // chartCubit: chartCubit,
                                          formattedPriceLess: formattedPriceLess,
                                          formattedPriceMore: formattedPriceMore,
                                          formattedMarketCap: formattedMarketCap,
                                          formattedVolume24h: formattedVolume24h,
                                          formattedCircSupply: formattedCircSupply,
                                          formattedMaxSupply: formattedMaxSupply,
                                          priceUsd: priceUsd,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: index == 0
                                      ? EdgeInsets.only(left: 16.0.w, right: 8.w)
                                      : index == 14
                                          ? EdgeInsets.only(right: 16.0.w)
                                          : EdgeInsets.only(right: 8.0.w),
                                  child: Container(
                                    height: 160.h,
                                    width: 145.w,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Color(0xff222531),
                                      borderRadius: BorderRadius.circular(18.w),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
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

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(reversedAsset.name, style: assetText),
                                              SizedBox(height: 2.0.h),
                                              Text(
                                                reversedAsset.priceUsd.length <= 18 ? _formattedPriceLess : _formattedPriceMore,
                                                style: subTitle,
                                              ),
                                            ],
                                          ),

                                          //up/down
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              move > 0.00001
                                                  ? SizedBox(
                                                      height: 18.h,
                                                      width: 18.w,
                                                      child: Icon(
                                                        Icons.arrow_drop_up,
                                                        color: Color(0xff00D7A3),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 18.h,
                                                      width: 18.w,
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Color(0xffED376A),
                                                      ),
                                                    ),

                                              SizedBox(width: 4.0.w),

                                              //percentage change
                                              Text(
                                                reversedAsset.changePercent24Hr.length == 18
                                                    ? reversedAsset.changePercent24Hr.replaceRange(4, null, '') + "%"
                                                    : reversedAsset.changePercent24Hr.length == 19
                                                        ? reversedAsset.changePercent24Hr.replaceRange(5, null, '') + "%"
                                                        : reversedAsset.changePercent24Hr.length == 20
                                                            ? reversedAsset.changePercent24Hr.replaceRange(6, null, '') + "%"
                                                            : null,
                                                style: percentageText.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 11.0.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else if (state is HomeContentLoadInProgress) {
                      return HomeAssetsLoadInProgress();
                    } else if (state is AssetsInitial) {
                      return Container(

                      );
                    } else
                      return Container(

                      );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
