import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/network/network_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/range_switcher/range_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/24h_chart/chart24h_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/all_coins/all_coins_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/chart/chart_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/screens/errors/avi_error.dart';
import 'package:cryptoboard/presentation/screens/errors/internal_error.dart';
import 'package:cryptoboard/presentation/screens/loading/description_load_in_progress.dart';
import 'package:cryptoboard/presentation/screens/loading/market_stats_load_in_progress.dart';
import 'package:cryptoboard/presentation/screens/loading/one_day_price_load_in_progress.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../widgets/coin_details/candlesticks_chart.dart';
import '../../widgets/coin_details/chart_date_range.dart';
import '../../widgets/coin_details/description_section.dart';
import '../../widgets/coin_details/extra_buttons.dart';
import '../../widgets/coin_details/market_stats.dart';
import '../../widgets/coin_details/market_stats_section_title.dart';
import '../../widgets/coin_details/one_day_price_details.dart';
import '../../widgets/coin_details/price_section_title.dart';

class CoinDetails extends StatelessWidget {
  final String icon;
  final ChartCubit chartCubit;
  final String rank;
  final String formattedMarketCap;
  final String formattedPriceMore;
  final String formattedPriceLess;
  final String formattedCircSupply;
  final String formattedMaxSupply;
  final String formattedVolume24h;
  final String symbol;
  final double move;
  final RangeSwitcherBloc rangeSwitcherBloc;
  final double priceUsd;
  final String name;
  final String priceUsdString;
  final String changePercent24Hr;
  final int index;
  const CoinDetails({
    Key key,
    this.icon,
    this.index,
    this.formattedMarketCap,
    this.formattedPriceMore,
    this.formattedPriceLess,
    this.move,
    this.priceUsd,
    this.name,
    this.symbol,
    this.priceUsdString,
    this.changePercent24Hr,
    this.rangeSwitcherBloc,
    this.formattedCircSupply,
    this.formattedMaxSupply,
    this.formattedVolume24h,
    this.rank,
    this.chartCubit,
  }) : super(key: key);

  // RefreshController _refreshController = RefreshController(initialRefresh: false);
  // // final ChartCubit chartCubitRefresh = BlocProvider.of<ChartCubit>(context);
  // void _onRefresh() async {
  //   // monitor network fetch
  //   BlocProvider.of<ChartCubit>(context).loadPastDayChart(symbol: symbol);
  //   BlocProvider.of<Chart24hCubit>(context).loadPastDayChart(symbol: symbol);
  //   BlocProvider.of<RangeSwitcherBloc>(context)..add(LoadPastDay());
  //   BlocProvider.of<AllCoinsCubit>(context).loadCoinData();
  //   // if failed,use refreshFailed()
  //   _refreshController.refreshCompleted();
  // }
  //
  // void _onLoading() async {
  //   // monitor network fetch
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // if failed,use loadFailed(),if no data return,use LoadNodata()
  //   // items.add((items.length+1).toString());
  //   if (mounted) setState(() {});
  //   _refreshController.loadComplete();
  // }

  @override
  Widget build(BuildContext context) {
    final Chart24hCubit chart24hCubit = BlocProvider.of<Chart24hCubit>(context);
    final AllCoinsCubit allCoinsCubit = BlocProvider.of<AllCoinsCubit>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            visualDensity: VisualDensity.compact,
            splashRadius: 20.w,
            padding: EdgeInsets.all(0),
            hoverColor: Color(0xff2777FF).withAlpha(80),
            splashColor: Color(0xff2777FF).withAlpha(80),
            highlightColor: Color(0xff2777FF).withAlpha(80),
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //name & price
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: Colors.black,
                    child: Container(
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        placeholder: (BuildContext, String) => ShimmerAvi(),
                        errorWidget: (BuildContext, String, _) => AviError(icon: icon),
                        imageUrl: 'https://icons.bitbot.tools/api/${icon}/64x64',
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ],
              ),

              //favorite
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.star_border,
                  size: 24,
                  color: Color(0xffCACED7),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            //body
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  //name & symbol
                  Padding(
                    padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w, right: 16.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${name} ",
                          style: initialsText.copyWith(fontSize: 12.0.sp),
                        ),
                        Text(
                          "(${symbol})",
                          style: initialsText.copyWith(fontSize: 12.0.sp),
                        ),
                      ],
                    ),
                  ),

                  //price & change
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h, left: 16.0.w, right: 16.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          priceUsdString.length <= 18 ? formattedPriceLess : formattedPriceMore,
                          style: assetText.copyWith(
                            fontSize: 24.0.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: move > 0.0001 ? Color(0xff07251D) : Color(0xff26090B),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                move > 0.0001
                                    ? SizedBox(
                                        height: 22.h,
                                        width: 22.w,
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.caretUp,
                                            color: Color(0xff00D7A3),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 24.h,
                                        width: 24.w,
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.caretDown,
                                            color: Color(0xffED376A),
                                          ),
                                        ),
                                      ),
                                Text(
                                  changePercent24Hr.length == 18
                                      ? changePercent24Hr.replaceRange(4, null, '') + "%"
                                      : changePercent24Hr.length == 19
                                          ? changePercent24Hr.replaceRange(5, null, '') + "%"
                                          : changePercent24Hr.length == 20
                                              ? changePercent24Hr.replaceRange(6, null, '') + "%"
                                              : '',
                                  style: percentageText.copyWith(
                                    fontSize: 15.0.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4.0.w),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //date range
                  ChartDateRange(chartCubit: chartCubit, symbol: symbol, rangeSwitcherBloc: rangeSwitcherBloc),

                  //chart
                  CandlesticksChart(chartCubit: chartCubit),

                  //other buttons
                  ExtraButtons(),

                  //price 24h
                  PriceSectionTitle(),

                  //24h details
                  BlocBuilder<Chart24hCubit, Chart24hState>(
                    cubit: chart24hCubit,
                    builder: (context, state) {
                      if (state is Chart24hLoadSuccess) {
                        final open = chart24hCubit.state.chartModel.data.data[index].open;
                        final close = chart24hCubit.state.chartModel.data.data[index].close;
                        final high = chart24hCubit.state.chartModel.data.data[index].high;
                        final low = chart24hCubit.state.chartModel.data.data[index].low;
                        final average = ((open + high) / 2);
                        final String oneDayOpen = chart24hCubit.state.chartModel.data.data[index].open.toString();
                        final String oneDayClose = chart24hCubit.state.chartModel.data.data[index].close.toString();
                        final String oneDayHigh = chart24hCubit.state.chartModel.data.data[index].high.toString();
                        final String oneDayLow = chart24hCubit.state.chartModel.data.data[index].low.toString();
                        final formattedAverage = NumberFormat.currency(symbol: '\$').format(average);
                        final formattedAverageSmall = NumberFormat.currency(symbol: '\$', decimalDigits: 4).format(average);
                        final formattedOpen = NumberFormat.currency(symbol: '\$').format(open);
                        final formattedOpenSmall = NumberFormat.currency(symbol: '\$', decimalDigits: 4).format(open);
                        final formattedClose = NumberFormat.currency(symbol: '\$').format(close);
                        final formattedCloseSmall = NumberFormat.currency(symbol: '\$', decimalDigits: 4).format(close);
                        final formattedHigh = NumberFormat.currency(symbol: '\$').format(high);
                        final formattedHighSmall = NumberFormat.currency(symbol: '\$', decimalDigits: 4).format(high);
                        final formattedLow = NumberFormat.currency(symbol: '\$').format(low);
                        final formattedLowSmall = NumberFormat.currency(symbol: '\$', decimalDigits: 4).format(low);

                        return OneDayPriceDetails(
                          move: move,
                          changePercent24Hr: changePercent24Hr,
                          open: open,
                          low: low,
                          high: high,
                          close: close,
                          oneDayClose: oneDayClose,
                          oneDayHigh: oneDayHigh,
                          oneDayLow: oneDayLow,
                          oneDayOpen: oneDayOpen,
                          formattedAverage: formattedAverage,
                          formattedAverageSmall: formattedAverageSmall,
                          formattedHigh: formattedHigh,
                          formattedHighSmall: formattedHighSmall,
                          formattedLow: formattedLow,
                          formattedLowSmall: formattedLowSmall,
                          formattedClose: formattedClose,
                          formattedCloseSmall: formattedCloseSmall,
                          formattedOpen: formattedOpen,
                          formattedOpenSmall: formattedOpenSmall,
                        );
                      }
                      if (state is Chart24hLoadInProgress) {
                        return OneDayPriceLoadInProgress();
                      }
                      if (state is Chart24hLoadFailure) {
                        return BlocBuilder<NetworkBloc, NetworkState>(
                          builder: (context, state) {
                            if (state is ConnectionFailure) {
                              return Container(
                                height: 400.h,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 80.0.w, right: 80.0.w, top: 20.0.h, bottom: 20.0.h),
                                      child: Container(
                                        width: 1.sw,
                                        color: Colors.black,
                                        child: Image.asset(
                                          'assets/images/no-internet.png',
                                          fit: BoxFit.fitWidth,
                                          width: 1.sw,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Oops! An error occurred',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0.sp,
                                        color: Color(0xff3861FB),
                                      ),
                                    ),
                                    SizedBox(height: 8.0.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0.w, right: 50.0.w),
                                      child: Text(
                                        'Please check your internet connection and try again',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14.0.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff82899E),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else
                              return InternalError();
                          },
                        );
                      }

                      return null;
                    },
                  ),

                  //title
                  MarketStatsSectionTitle(),

                  //market stats
                  BlocBuilder<Chart24hCubit, Chart24hState>(
                    cubit: chart24hCubit,
                    builder: (context, state) {
                      if (state is Chart24hLoadSuccess) {
                        return MarketStats(
                          chartCubit: chartCubit,
                          formattedCircSupply: formattedCircSupply,
                          formattedMaxSupply: formattedMaxSupply == null ? 'N/A' : formattedMaxSupply,
                          formattedVolume24h: formattedVolume24h,
                          rank: rank,
                          formattedMarketCap: formattedMarketCap,
                        );
                      }

                      if (state is Chart24hLoadInProgress) {
                        return MarketStatsLoadInProgress();
                      }

                      if (state is Chart24hLoadFailure) {
                        return BlocBuilder<NetworkBloc, NetworkState>(
                          builder: (context, state) {
                            if (state is ConnectionFailure) {
                              return Container(
                                height: 400.h,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 80.0.w, right: 80.0.w, top: 20.0.h, bottom: 20.0.h),
                                      child: Container(
                                        width: 1.sw,
                                        color: Colors.black,
                                        child: Image.asset(
                                          'assets/images/no-internet.png',
                                          fit: BoxFit.fitWidth,
                                          width: 1.sw,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Oops! An error occurred',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0.sp,
                                        color: Color(0xff3861FB),
                                      ),
                                    ),
                                    SizedBox(height: 8.0.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0.w, right: 50.0.w),
                                      child: Text(
                                        'Please check your internet connection and try again',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14.0.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff82899E),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else
                              return InternalError();
                          },
                        );
                      }
                      return null;
                    },
                  ),

                  //separator
                  Padding(
                    padding: EdgeInsets.only(top: 32.0.h, left: 16.0.w, right: 16.0.w, bottom: 32.0.h),
                    child: Container(
                      color: Color(0xff23262D),
                      height: 1.h,
                      width: 1.sw,
                    ),
                  ),

                  //description
                  BlocBuilder<AllCoinsCubit, AllCoinsState>(
                    cubit: allCoinsCubit,
                    builder: (context, state) {
                      if (state is AllCoinsLoadSuccess) {
                        final coinDescription = allCoinsCubit.state.allCoinsModel.data['${symbol}'].description;
                        final coinAlgorithm = allCoinsCubit.state.allCoinsModel.data['${symbol}'].algorithm;
                        final coinProofType = allCoinsCubit.state.allCoinsModel.data['${symbol}'].proofType;
                        return DescriptionSection(
                          symbol: symbol,
                          name: name,
                          coinDescription: coinDescription,
                          coinAlgorithm: coinAlgorithm,
                          coinProofType: coinProofType,
                        );
                      }
                      if (state is AllCoinsLoadInProgress) {
                        return DescriptionLoadInProgress(
                          name: name,
                          symbol: symbol,
                        );
                      }

                      if (state is AllCoinsLoadFailure) {
                        return BlocBuilder<NetworkBloc, NetworkState>(
                          builder: (context, state) {
                            if (state is ConnectionFailure) {
                              return Container(
                                height: 400.h,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 80.0.w, right: 80.0.w, top: 20.0.h, bottom: 20.0.h),
                                      child: Container(
                                        width: 1.sw,
                                        color: Colors.black,
                                        child: Image.asset(
                                          'assets/images/no-internet.png',
                                          fit: BoxFit.fitWidth,
                                          width: 1.sw,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Oops! An error occurred',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0.sp,
                                        color: Color(0xff3861FB),
                                      ),
                                    ),
                                    SizedBox(height: 8.0.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0.w, right: 50.0.w),
                                      child: Text(
                                        'Please check your internet connection and try again',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14.0.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff82899E),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else
                              return InternalError();
                          },
                        );
                      }
                      return null;
                    },
                  ),

                  Container(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
