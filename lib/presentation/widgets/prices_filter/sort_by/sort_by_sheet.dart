import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_now_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortBySheet extends StatelessWidget {
  final AssetsCubit assetsCubit;
  final SortCubit sortCubit;
  final SortNowCubit sortNowCubit;
  SortBySheet({Key key, this.sortCubit, this.assetsCubit, this.sortNowCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetsCubit, AssetsState>(
      buildWhen: (AssetsInitial, AssetsState) => true,
      cubit: assetsCubit,
      builder: (context, state) {
        return Container(
          height: 448.h,
          color: Colors.black,
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            children: [
              //title
              Container(
                color: Color(0xff23262D),
                child: ListTile(
                  title: Text(
                    'Sort By',
                    style: normalText.copyWith(color: Colors.white),
                  ),
                ),
              ),

              //rank
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  if (state is! AssetsSortedByRankAscending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByRankAscending();
                    sortCubit.sortByRank();
                  } else if (state is AssetsSortedByRankAscending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByRankDescending();
                    sortCubit.sortByRank();
                  }
                },
                title: sortCubit.state is SortedByRank || sortCubit.state is SortInitial
                    ? Row(
                        children: [
                          Text(
                            'Rank',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.arrow_downward,
                            color: state is AssetsSortedByRankDescending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: state is AssetsSortedByRankAscending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            'Rank',
                            style: normalText,
                          ),
                          SizedBox(width: 10.w),
                          Container(),
                          Container(),
                        ],
                      ),
              ),

              //market cap
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  if (state is! AssetsSortedByMarketCapDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByMarketCapDescending();
                    sortCubit.sortByMarketCap();
                  } else if (state is AssetsSortedByMarketCapDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByMarketCapAscending();
                    sortCubit.sortByMarketCap();
                  }
                },
                title: sortCubit.state is SortedByMarketCap
                    ? Row(
                        children: [
                          Text(
                            'Market Cap',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.arrow_downward,
                            color: state is AssetsSortedByMarketCapDescending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: state is AssetsSortedByMarketCapAscending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            'Market Cap',
                            style: normalText,
                          ),
                          SizedBox(width: 10.w),
                          Container(),
                          Container(),
                        ],
                      ),
              ),

              //% change
              ListTile(
                onTap: () {
                  Navigator.pop(context);

                  if (state is! AssetsSortedByPercentageChangeDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByPercentageChangeDescending();
                    sortCubit.sortByPercentageChange();
                  } else if (state is AssetsSortedByPercentageChangeDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByPercentageChangeAscending();
                    sortCubit.sortByPercentageChange();
                  }
                },
                title: sortCubit.state is SortedByPercentageChange
                    ? Row(
                        children: [
                          Text(
                            '% Change',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.arrow_downward,
                            color: state is AssetsSortedByPercentageChangeDescending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: state is AssetsSortedByPercentageChangeAscending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            '% Change',
                            style: normalText,
                          ),
                          SizedBox(width: 10.w),
                          Container(),
                          Container(),
                        ],
                      ),
              ),

              //price
              ListTile(
                onTap: () {
                  Navigator.pop(context);

                  if (state is! AssetsSortedByPriceDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByPriceDescending();
                    sortCubit.sortByPrice();
                  } else if (state is AssetsSortedByPriceDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByPriceAscending();
                    sortCubit.sortByPrice();
                  }
                },
                title: sortCubit.state is SortedByPrice
                    ? Row(
                        children: [
                          Text(
                            'Price',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.arrow_downward,
                            color: state is AssetsSortedByPriceDescending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: state is AssetsSortedByPriceAscending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            'Price',
                            style: normalText,
                          ),
                          SizedBox(width: 10.w),
                          Container(),
                          Container(),
                        ],
                      ),
              ),

              //volume 24h
              ListTile(
                onTap: () {
                  Navigator.pop(context);

                  if (state is! AssetsSortedByVolume24hrDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByVolume24hrDescending();
                    sortCubit.sortByVolume24hr();
                  } else if (state is AssetsSortedByVolume24hrDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByVolume24hrAscending();
                    sortCubit.sortByVolume24hr();
                  }
                },
                title: sortCubit.state is SortedByVolume24hr
                    ? Row(
                        children: [
                          Text(
                            'Volume 24hr',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.arrow_downward,
                            color: state is AssetsSortedByVolume24hrDescending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: state is AssetsSortedByVolume24hrAscending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            'Volume 24hr',
                            style: normalText,
                          ),
                          SizedBox(width: 10.w),
                          Container(),
                          Container(),
                        ],
                      ),
              ),

              //max supply
              ListTile(
                onTap: () {
                  Navigator.pop(context);

                  if (state is! AssetsSortedByMaxSupplyDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByMaxSupplyDescending();
                    sortCubit.sortByMaxSupply();
                  } else if (state is AssetsSortedByMaxSupplyDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByMaxSupplyAscending();
                    sortCubit.sortByMaxSupply();
                  }
                },
                title: sortCubit.state is SortedByMaxSupply
                    ? Row(
                        children: [
                          Text(
                            'Max Supply',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.arrow_downward,
                            color: state is AssetsSortedByMaxSupplyDescending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: state is AssetsSortedByMaxSupplyAscending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            'Max Supply',
                            style: normalText,
                          ),
                          SizedBox(width: 10.w),
                          Container(),
                          Container(),
                        ],
                      ),
              ),

              //name
              ListTile(
                onTap: () {
                  Navigator.pop(context);

                  if (state is! AssetsSortedByNameDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByNameDescending();
                    sortCubit.sortByName();
                  } else if (state is AssetsSortedByNameDescending && sortNowCubit.state is SortNowInitial) {
                    assetsCubit.sortAssetsByNameAscending();
                    sortCubit.sortByName();
                  }
                },
                title: sortCubit.state is SortedByName
                    ? Row(
                        children: [
                          Text(
                            'Name',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.arrow_downward,
                            color: state is AssetsSortedByNameDescending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: state is AssetsSortedByNameAscending ? Colors.blue : Color(0xff646B80),
                            size: 15,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            'Name',
                            style: normalText,
                          ),
                          SizedBox(width: 10.w),
                          Container(),
                          Container(),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
