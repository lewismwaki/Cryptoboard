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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

class TopCoinsSection extends StatefulWidget {
  const TopCoinsSection({Key key}) : super(key: key);

  @override
  _TopCoinsSectionState createState() => _TopCoinsSectionState();
}

class _TopCoinsSectionState extends State<TopCoinsSection> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final HomeContentCubit _homeContentCubit = BlocProvider.of<HomeContentCubit>(context);
    final RangeSwitcherBloc rangeSwitcherBloc = BlocProvider.of<RangeSwitcherBloc>(context);
    final AllCoinsCubit allCoinsCubit = BlocProvider.of<AllCoinsCubit>(context);
    final ChartCubit chartCubit = BlocProvider.of<ChartCubit>(context);
    final Chart24hCubit chart24hCubit = BlocProvider.of<Chart24hCubit>(context);

    return BlocBuilder<HomeContentCubit, HomeContentState>(
      cubit: _homeContentCubit,
      builder: (BuildContext context, state) {
        if (state is HomeContentLoadSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
            child: Container(
              height: 180.h,
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                cacheExtent: 15,
                addRepaintBoundaries: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (context, index) {
                  //pick
                  final assetClass = state.assetsClass.data;
                  final sortedByRankAscending = assetClass.sortedByNum((element) => double.parse(element.rank));
                  final asset = sortedByRankAscending[index];

                  //asset data
                  final icon = asset.symbol.toLowerCase();
                  final name = asset.name;
                  final symbol = asset.symbol;
                  final rank = asset.rank;
                  final changePercent24Hr = asset.changePercent24Hr;
                  final String priceUsdString = asset.priceUsd;
                  final double move = double.parse(asset.changePercent24Hr);
                  final double priceUsd = double.parse(asset.priceUsd);
                  final double marketCapUsd = double.parse(asset.marketCapUsd);
                  final double volume24h = double.parse(asset.volumeUsd24Hr);
                  final double circSupply = double.parse(asset.supply);
                  final formattedPriceMore = NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(priceUsd);
                  final formattedPriceLess = NumberFormat.currency(decimalDigits: 8, symbol: '\$').format(priceUsd);
                  final formattedMarketCap = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
                  final formattedVolume24h = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(volume24h);
                  final formattedCircSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(circSupply);
                  final formattedMaxSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$')
                      .format(asset.maxSupply == null ? 1 : double.parse(asset.maxSupply));
                  return GestureDetector(
                    onTap: () {
                      chartCubit.loadPastDayChart(symbol: symbol);
                      chart24hCubit.loadPastDayChart(symbol: symbol);
                      rangeSwitcherBloc..add(LoadPastDay());
                      allCoinsCubit.loadCoinData();
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
                                radius: 19.r,
                                backgroundColor: Colors.black,
                                child: Container(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    errorWidget: (BuildContext, String, _) => CircleAvatar(
                                      radius: 19.r,
                                      backgroundColor: Color(0xff303441),
                                      child: Image(
                                        image: AssetImage('assets/icons/$icon.png'),
                                      ),
                                    ),
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
                                  Text(asset.name, style: assetText),
                                  SizedBox(height: 2.0.h),
                                  Text(
                                    asset.priceUsd.length <= 18 ? formattedPriceLess : formattedPriceMore,
                                    style: subTitle,
                                  ),
                                ],
                              ),

                              //up/down
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                    asset.changePercent24Hr.length == 18
                                        ? asset.changePercent24Hr.replaceRange(4, null, '') + "%"
                                        : asset.changePercent24Hr.length == 19
                                            ? asset.changePercent24Hr.replaceRange(5, null, '') + "%"
                                            : asset.changePercent24Hr.length == 20
                                                ? asset.changePercent24Hr.replaceRange(6, null, '') + "%"
                                                : '',
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
