import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/network/network_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/range_switcher/range_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/24h_chart/chart24h_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/all_coins/all_coins_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/chart/chart_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/coin_details/coin_details.dart';
import 'package:cryptoboard/presentation/screens/errors/avi_error.dart';
import 'package:cryptoboard/presentation/screens/errors/network_error.dart';
import 'package:cryptoboard/presentation/screens/loading/assets_load_in_progress_shimmer.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

class TopGainersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RangeSwitcherBloc rangeSwitcherBloc = BlocProvider.of<RangeSwitcherBloc>(context);
    final AllCoinsCubit allCoinsCubit = BlocProvider.of<AllCoinsCubit>(context);
    final ChartCubit chartCubit = BlocProvider.of<ChartCubit>(context);
    final Chart24hCubit chart24hCubit = BlocProvider.of<Chart24hCubit>(context);

    final _assetsCubit = BlocProvider.of<AssetsCubit>(context);

    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionFailure) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                NetworkError(),
              ],
            ),
          );
        }
        if (state is ConnectionSuccess) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 1.sh - 170.h,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: ListView.separated(
                      itemCount: 10,
                      cacheExtent: 10,
                      addRepaintBoundaries: true,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, int) => Divider(
                        height: 1.h,
                        color: Color(0xff646B80),
                      ),
                      itemBuilder: (context, index) {
                        return BlocBuilder<AssetsCubit, AssetsState>(
                          cubit: _assetsCubit,
                          builder: (context, state) {
                            if (state is AssetsSortedByPercentageChangeDescending) {
                              final assetClass = state.assetsClass.data;
                              final sortedByPercentageChangeDescending =
                                  assetClass.sortedByNum((element) => double.parse(element.changePercent24Hr)).reversed.toList();
                              final reversedAsset = sortedByPercentageChangeDescending[index];
                              final double move = double.parse(reversedAsset.changePercent24Hr);
                              final double marketCapUsd = double.parse(reversedAsset.marketCapUsd);
                              final double priceUsd = double.parse(reversedAsset.priceUsd);
                              final icon = reversedAsset.symbol.toLowerCase();
                              final _formattedMarketCap =
                                  NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
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
                                          rangeSwitcherBloc: rangeSwitcherBloc,
                                          move: move,
                                          index: index,
                                          changePercent24Hr: changePercent24Hr,
                                          priceUsdString: priceUsdString,
                                          icon: icon,
                                          name: name,
                                          symbol: symbol,
                                          rank: rank,
                                          chartCubit: chartCubit,
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
                                  padding: EdgeInsets.only(bottom: 15.h, top: 15.h, right: 16.0.w, left: 16.0.w),
                                  child: Container(
                                    height: 44.h,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        //avi
                                        Row(
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
                                                  errorWidget: (BuildContext, String, _) => AviError(icon: icon),
                                                  imageUrl: 'https://icons.bitbot.tools/api/$icon/64x64',
                                                  filterQuality: FilterQuality.medium,
                                                ),
                                              ),
                                            ),

                                            //first section
                                            SizedBox(width: 8.0.w),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    //reversedAsset
                                                    Text(
                                                      reversedAsset.name,
                                                      style: assetText,
                                                    ),
                                                  ],
                                                ),

                                                //details
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    //rank
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
                                                          reversedAsset.rank,
                                                          style: rankText,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(width: 4.0.w),

                                                    //asset symbol
                                                    Text(
                                                      reversedAsset.symbol,
                                                      style: initialsText,
                                                    ),

                                                    SizedBox(width: 0.0.w),

                                                    //up/down
                                                    move > 0.0001
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

                                                    SizedBox(width: 6.0.w),

                                                    //percentage change
                                                    Text(
                                                      reversedAsset.changePercent24Hr.length == 18
                                                          ? reversedAsset.changePercent24Hr.replaceRange(4, null, '') + "%"
                                                          : reversedAsset.changePercent24Hr.length == 19
                                                              ? reversedAsset.changePercent24Hr.replaceRange(5, null, '') + "%"
                                                              : reversedAsset.changePercent24Hr.length == 20
                                                                  ? reversedAsset.changePercent24Hr.replaceRange(6, null, '') + "%"
                                                                  : '',
                                                      style: percentageText,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        //last section
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                //price
                                                Text(
                                                  reversedAsset.priceUsd.length <= 18 ? _formattedPriceLess : _formattedPriceMore,
                                                  style: assetText,
                                                ),

                                                //market cap
                                                Text(
                                                  "Market Cap: " + _formattedMarketCap.toString(),
                                                  style: initialsText,
                                                ), //favourite icon
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 14.0.w),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Icon(
                                                    Icons.star_border,
                                                    size: 18,
                                                    color: Color(0xff323546),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (state is AssetsSortedByPercentageChangeAscending) {
                              final assetClass = state.assetsClass.data;
                              final sortedByPercentageChangeDescending =
                                  assetClass.sortedByNum((element) => double.parse(element.changePercent24Hr)).reversed.toList();
                              final reversedAsset = sortedByPercentageChangeDescending[index];
                              final double move = double.parse(reversedAsset.changePercent24Hr);
                              final double marketCapUsd = double.parse(reversedAsset.marketCapUsd);
                              final double priceUsd = double.parse(reversedAsset.priceUsd);
                              final icon = reversedAsset.symbol.toLowerCase();
                              final _formattedMarketCap =
                                  NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
                              final _formattedPriceMore = NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(priceUsd);
                              final _formattedPriceLess = NumberFormat.currency(decimalDigits: 8, symbol: '\$').format(priceUsd);
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h, top: 15.h, right: 16.0.w, left: 16.0.w),
                                child: Container(
                                  height: 44.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //avi
                                      Row(
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
                                                filterQuality: FilterQuality.medium,
                                              ),
                                            ),
                                          ),

                                          //first section
                                          SizedBox(width: 8.0.w),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  //reversedAsset
                                                  Text(
                                                    reversedAsset.name,
                                                    style: assetText,
                                                  ),
                                                ],
                                              ),

                                              //details
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  //rank
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
                                                        reversedAsset.rank,
                                                        style: rankText,
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 4.0.w),

                                                  //asset symbol
                                                  Text(
                                                    reversedAsset.symbol,
                                                    style: initialsText,
                                                  ),

                                                  SizedBox(width: 0.0.w),

                                                  //up/down
                                                  move > 0.0001
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

                                                  SizedBox(width: 6.0.w),

                                                  //percentage change
                                                  Text(
                                                    reversedAsset.changePercent24Hr.length == 18
                                                        ? reversedAsset.changePercent24Hr.replaceRange(4, null, '') + "%"
                                                        : reversedAsset.changePercent24Hr.length == 19
                                                            ? reversedAsset.changePercent24Hr.replaceRange(5, null, '') + "%"
                                                            : reversedAsset.changePercent24Hr.length == 20
                                                                ? reversedAsset.changePercent24Hr.replaceRange(6, null, '') + "%"
                                                                : '',
                                                    style: percentageText,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      //last section
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              //price
                                              Text(
                                                reversedAsset.priceUsd.length <= 18 ? _formattedPriceLess : _formattedPriceMore,
                                                style: assetText,
                                              ),

                                              //market cap
                                              Text(
                                                "Market Cap: " + _formattedMarketCap.toString(),
                                                style: initialsText,
                                              ), //favourite icon
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 14.0.w),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.star_border,
                                                  size: 18,
                                                  color: Color(0xff323546),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            if (state is AssetsLoadInProgress) {
                              return AssetsLoadInProgressShimmer();
                            } else
                              return AssetsLoadInProgressShimmer();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return null;
      },
    );
  }
}
