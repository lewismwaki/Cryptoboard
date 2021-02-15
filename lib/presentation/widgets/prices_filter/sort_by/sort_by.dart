import 'package:cryptoboard/business_logic/blocs/prices_switcher/prices_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_now_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sort_by_sheet.dart';

class SortBy extends StatelessWidget {
  final AssetsCubit assetsCubit;
  final SortCubit sortCubit;
  final SortNowCubit sortNowCubit;
  const SortBy({Key key, this.sortCubit, this.assetsCubit, this.sortNowCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PricesSwitcherBloc pricesSwitcherBloc = BlocProvider.of<PricesSwitcherBloc>(context);

    return BlocBuilder<AssetsCubit, AssetsState>(
        cubit: assetsCubit,
        builder: (context, state) {
          return MaterialButton(
            height: 40.0.h,
            minWidth: 0.0.w,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Color(0xff323546),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            onPressed: () {
              pricesSwitcherBloc..add(LoadAssetsList());
              sortNowCubit.SortNowInitiate();
              showModalBottomSheet(
                isDismissible: true,
                enableDrag: false,
                isScrollControlled: false,
                context: context,
                builder: (context) => SortBySheet(
                  assetsCubit: assetsCubit,
                  sortCubit: sortCubit,
                  sortNowCubit: sortNowCubit,
                ),
              );
            },
            child: Row(
              children: [
                // sort type
                Text(
                  sortCubit.state is SortedByRank
                      ? 'Sort By Rank'
                      : sortCubit.state is SortedByMarketCap
                          ? 'Sort By Market Cap'
                          : sortCubit.state is SortedByPercentageChange
                              ? 'Sort By % Change'
                              : sortCubit.state is SortedByPrice
                                  ? 'Sort By Price'
                                  : sortCubit.state is SortedByVolume24hr
                                      ? 'Sort By Volume 24hr'
                                      : sortCubit.state is SortedByMaxSupply
                                          ? 'Sort By Max Supply'
                                          : sortCubit.state is SortedByName
                                              ? 'Sort By Name'
                                              : sortCubit.state is SortInitial
                                                  ? 'Sort By Rank'
                                                  : '',
                  style: normalText,
                ),
                SizedBox(width: 5.w),

                //icon
                Icon(
                  state is AssetsSortedByRankAscending
                      ? Icons.arrow_upward
                      : state is AssetsSortedByRankDescending
                          ? Icons.arrow_downward
                          : state is AssetsSortedByMarketCapAscending
                              ? Icons.arrow_upward
                              : state is AssetsSortedByMarketCapDescending
                                  ? Icons.arrow_downward
                                  : state is AssetsSortedByPercentageChangeAscending
                                      ? Icons.arrow_upward
                                      : state is AssetsSortedByPercentageChangeDescending
                                          ? Icons.arrow_downward
                                          : state is AssetsSortedByPriceAscending
                                              ? Icons.arrow_upward
                                              : state is AssetsSortedByPriceDescending
                                                  ? Icons.arrow_downward
                                                  : state is AssetsSortedByNameAscending
                                                      ? Icons.arrow_upward
                                                      : state is AssetsSortedByNameDescending
                                                          ? Icons.arrow_downward
                                                          : state is AssetsSortedByMaxSupplyAscending
                                                              ? Icons.arrow_upward
                                                              : state is AssetsSortedByMaxSupplyDescending
                                                                  ? Icons.arrow_downward
                                                                  : state is AssetsSortedByVolume24hrAscending
                                                                      ? Icons.arrow_upward
                                                                      : state is AssetsSortedByVolume24hrDescending
                                                                          ? Icons.arrow_downward
                                                                          : Icons.auto_fix_high,
                  color: Colors.blue,
                  size: 15,
                )
              ],
            ),
          );
        });
  }
}
