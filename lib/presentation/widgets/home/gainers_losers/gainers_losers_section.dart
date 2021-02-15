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

class GainersLosersSection extends StatefulWidget {
  @override
  _GainersLosersSectionState createState() => _GainersLosersSectionState();
}

class _GainersLosersSectionState extends State<GainersLosersSection> with AutomaticKeepAliveClientMixin {
  Widget build(BuildContext context) {
    final RangeSwitcherBloc rangeSwitcherBloc = BlocProvider.of<RangeSwitcherBloc>(context);
    final AllCoinsCubit allCoinsCubit = BlocProvider.of<AllCoinsCubit>(context);
    final ChartCubit chartCubit = BlocProvider.of<ChartCubit>(context);
    final Chart24hCubit chart24hCubit = BlocProvider.of<Chart24hCubit>(context);
    final _homeContentCubit = BlocProvider.of<HomeContentCubit>(context);
    return BlocBuilder<HomeContentCubit, HomeContentState>(
      cubit: _homeContentCubit,
      builder: (BuildContext context, state) {
        if (state is HomeContentLoadSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
            child: Container(
              height: 180.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
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
                  final formattedMarketCap = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
                  final formattedVolume24h = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(volume24h);
                  final formattedCircSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(circSupply);
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
                          maintainState: false,
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
                                    errorWidget: (BuildContext, String, _) => CircleAvatar(
                                      radius: 19.r,
                                      backgroundColor: Color(0xff303441),
                                      child: Image(
                                        image: AssetImage('assets/icons/$icon.png'),
                                      ),
                                    ),
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
                                                : reversedAsset.changePercent24Hr.length == 21
                                                    ? reversedAsset.changePercent24Hr.replaceRange(7, null, '') + "%"
                                                    : null,
                                    style: percentageText.copyWith(
                                      color: Colors.white,
                                      fontSize: 11.0.ssp,
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
            height: 200,
            color: Colors.black,
          );
        } else
          return Container(
            height: 200,
            color: Colors.black,
          );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
