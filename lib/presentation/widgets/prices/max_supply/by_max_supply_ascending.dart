import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/range_switcher/range_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/watchlist/watchlist_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/24h_chart/chart24h_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/all_coins/all_coins_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/chart/chart_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/data/models/asset/asset_model.dart';
import 'package:cryptoboard/presentation/pages/coin_details/coin_details.dart';
import 'package:cryptoboard/presentation/screens/errors/avi_error.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:supercharged/supercharged.dart';

class ByMaxSupplyAscending extends StatelessWidget {
  final int index;
  ByMaxSupplyAscending({this.index});

  @override
  Widget build(BuildContext context) {
    final RangeSwitcherBloc rangeSwitcherBloc = BlocProvider.of<RangeSwitcherBloc>(context);
    final AllCoinsCubit allCoinsCubit = BlocProvider.of<AllCoinsCubit>(context);
    final ChartCubit chartCubit = BlocProvider.of<ChartCubit>(context);
    final Chart24hCubit chart24hCubit = BlocProvider.of<Chart24hCubit>(context);

    final _assetsCubit = BlocProvider.of<AssetsCubit>(context);
    return BlocBuilder<AssetsCubit, AssetsState>(
      cubit: _assetsCubit,
      builder: (context, state) {
        if (state is AssetsSortedByMaxSupplyAscending) {
          final assetClass = state.assetsClass.data;
          final sortedByMaxSupplyAscending = assetClass.sortedByNum((element) => element.maxSupply == null ? 0 : double.parse(element.maxSupply));
          final asset = sortedByMaxSupplyAscending[index];
          final double move = double.parse(asset.changePercent24Hr);
          final double marketCapUsd = double.parse(asset.marketCapUsd);
          final double priceUsd = double.parse(asset.priceUsd);
          final icon = asset.symbol.toLowerCase();

          final formattedMarketCap = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(marketCapUsd);
          final formattedPriceMore = NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(priceUsd);
          final formattedPriceLess = NumberFormat.currency(decimalDigits: 8, symbol: '\$').format(priceUsd);
          final name = asset.name;
          final symbol = asset.symbol;
          final rank = asset.rank;
          final changePercent24Hr = asset.changePercent24Hr;
          final String priceUsdString = asset.priceUsd;
          final double volume24h = double.parse(asset.volumeUsd24Hr);
          final double circSupply = double.parse(asset.supply);
          final formattedVolume24h = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(volume24h);
          final formattedCircSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$').format(circSupply);
          final formattedMaxSupply = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'en_US', symbol: '\$')
              .format(asset.maxSupply == null ? 1 : double.parse(asset.maxSupply));

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
                                //asset
                                Text(
                                  asset.name,
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
                                      asset.rank,
                                      style: rankText,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 4.0.w),

                                //asset symbol
                                Text(
                                  asset.symbol,
                                  style: initialsText,
                                ),

                                SizedBox(width: 0.0.w),

                                //up/down
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

                                SizedBox(width: 6.0.w),

                                //percentage change
                                Text(
                                  asset.changePercent24Hr.length == 18
                                      ? asset.changePercent24Hr.replaceRange(4, null, '') + "%"
                                      : asset.changePercent24Hr.length == 19
                                          ? asset.changePercent24Hr.replaceRange(5, null, '') + "%"
                                          : asset.changePercent24Hr.length == 20
                                              ? asset.changePercent24Hr.replaceRange(6, null, '') + "%"
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
                              asset.priceUsd.length <= 18 ? formattedPriceLess : formattedPriceMore,
                              style: assetText,
                            ),

                            //market cap
                            Text(
                              "Market Cap: " + formattedMarketCap.toString(),
                              style: initialsText,
                            ), //favourite icon
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 14.0.w),
                            SizedBox(
                              height: 18.0.h,
                              width: 18.0.h,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.star_border,
                                  size: 18,
                                  color: Color(0xff323546),
                                ),
                                onPressed: () {
                                  BlocProvider.of<WatchListBloc>(context)
                                    ..add(
                                      WatchListEvent.add(
                                        addedAsset: Asset(
                                          symbol: asset.symbol,
                                          name: asset.name,
                                          changePercent24Hr: asset.changePercent24Hr,
                                          id: asset.id,
                                          marketCapUsd: asset.marketCapUsd,
                                          maxSupply: asset.maxSupply,
                                          priceUsd: asset.priceUsd,
                                          rank: asset.rank,
                                          supply: asset.supply,
                                          volumeUsd24Hr: asset.volumeUsd24Hr,
                                          vwap24Hr: asset.vwap24Hr,
                                        ),
                                      ),
                                    );
                                  showCustomNotification(
                                    title: 'Feature still in development',
                                    subtitle: 'Be sure to check after subsequent releases',
                                    icon: MdiIcons.beta,
                                    iconColor: Colors.white,
                                    iconBackgroundColor: Color(0xff555E8D),
                                    seconds: 3,
                                    padding: EdgeInsets.only(top: 8.0.h),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return null;
      },
    );
  }
}
