import 'package:cryptoboard/business_logic/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/network/network_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/prices_switcher/prices_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/watchlist/watchlist_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_now_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/data/models/asset/asset_model.dart';
import 'package:cryptoboard/presentation/pages/search/search_page.dart';
import 'package:cryptoboard/presentation/screens/errors/network_error.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:cryptoboard/presentation/widgets/prices/watchlist/watchlist.dart';
import 'package:cryptoboard/presentation/widgets/prices/watchlist/watchlist_empty.dart';
import 'package:cryptoboard/presentation/widgets/prices_filter/base_currency/base_currency.dart';
import 'package:cryptoboard/presentation/widgets/prices_filter/limit_to/limit_to.dart';
import 'package:cryptoboard/presentation/widgets/prices_filter/looking_for/looking_for.dart';
import 'package:cryptoboard/presentation/widgets/prices_filter/percentage_change/percentage_change.dart';
import 'package:cryptoboard/presentation/widgets/prices_filter/sort_by/sort_by.dart';
import 'package:cryptoboard/presentation/widgets/prices_filter/watchlist/watchlist_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'assets.dart';

class PricesPageBody extends StatelessWidget {
  final AssetsCubit assetsCubit;
  final SortCubit sortCubit;
  final SortNowCubit sortNowCubit;
  final NewsBloc newsBloc;
  final TabSwitcherBloc tabSwitcherBloc;

  const PricesPageBody({Key key, this.assetsCubit, this.sortCubit, this.sortNowCubit, this.newsBloc, this.tabSwitcherBloc}) : super(key: key);

  Widget build(BuildContext context) {
    final AssetsCubit assetsCubit = BlocProvider.of<AssetsCubit>(context);
    final HomeContentCubit homeContentCubit = BlocProvider.of<HomeContentCubit>(context);
    final WatchListBloc watchListBloc = BlocProvider.of<WatchListBloc>(context);
    final PricesSwitcherBloc pricesSwitcherBloc = BlocProvider.of<PricesSwitcherBloc>(context);
    final BottomNavBarBloc _bottomNavBarBloc = BlocProvider.of<BottomNavBarBloc>(context);
    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      cubit: _bottomNavBarBloc,
      builder: (context, state) {
        if (state is LoadedPricesPage) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                brightness: Brightness.dark,
                backgroundColor: Colors.black,
                centerTitle: false,
                floating: false,
                elevation: 0.0,
                expandedHeight: 93.h,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      child: Text(
                        'Cryptoassets',
                        style: appBarText.copyWith(
                          fontSize: 16.0.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    MaterialButton(
                      padding: EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      onPressed: () {
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
                      child: Text(
                        'Exchanges',
                        style: appBarText.copyWith(
                          fontSize: 16.0.sp,
                          color: Color(0xff646B80),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Color(0xff858CA2),
                      ),
                      onPressed: () {
                        showSearch(delegate: SearchPage(homeContentCubit: homeContentCubit), context: context);
                      },
                    ),
                  ),
                ],
                flexibleSpace: Padding(
                  padding: EdgeInsets.only(top: 58.0.h),
                  child: Container(
                    height: 35.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        //favourites
                        WatchListBtn(),

                        SizedBox(width: 8.w),

                        //base currency
                        BaseCurrency(),

                        SizedBox(width: 8.w),

                        //sort by
                        SortBy(assetsCubit: assetsCubit, sortCubit: sortCubit, sortNowCubit: sortNowCubit),
                        SizedBox(width: 8.w),

                        //percentage change
                        PercentageChange(assetsCubit: assetsCubit),

                        SizedBox(width: 8.w),

                        //limit to
                        LimitTo(assetsCubit: assetsCubit),

                        SizedBox(width: 8.w),

                        //looking fore
                        LookingFor(assetsCubit: assetsCubit),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    BlocBuilder<AssetsCubit, AssetsState>(
                      builder: (context, assetCubitState) {
                        if (assetCubitState is AssetsLoadFailure) {
                          return BlocBuilder<NetworkBloc, NetworkState>(
                            builder: (context, state) {
                              if (state is ConnectionFailure) {
                                return NetworkError();
                              } else {
                                assetsCubit.sortAssetsByRankAscending();
                                return Container(
                                  height: 1.sh - 176.h,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: BlocBuilder<PricesSwitcherBloc, PricesSwitcherState>(
                                      cubit: pricesSwitcherBloc,
                                      builder: (context, pricesSwitcherBlocState) {
                                        return BlocBuilder<WatchListBloc, List<Asset>>(
                                          cubit: watchListBloc,
                                          builder: (context, assetList) {
                                            return ListView.separated(
                                              itemCount: pricesSwitcherBlocState is AssetsListLoaded ? 100 : assetList.length,
                                              addRepaintBoundaries: true,
                                              cacheExtent: 100,
                                              addAutomaticKeepAlives: true,
                                              scrollDirection: Axis.vertical,
                                              separatorBuilder: (context, int) => Divider(
                                                height: 1,
                                                color: Color(0xff646B80),
                                              ),
                                              itemBuilder: (context, index) {
                                                if (pricesSwitcherBlocState is AssetsListLoaded) {
                                                  return Assets(index: index);
                                                }

                                                if (pricesSwitcherBlocState is WatchListLoaded) {
                                                  if (assetList.length != 0) {
                                                    return WatchList(index: index, watchListBloc: watchListBloc);
                                                  }

                                                  if (assetList.length == 0) {
                                                    return WatchListEmpty();
                                                  }
                                                }
                                                return null;
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          return Container(
                            height: 1.sh - 176.h,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: BlocBuilder<PricesSwitcherBloc, PricesSwitcherState>(
                                cubit: pricesSwitcherBloc,
                                builder: (context, pricesSwitcherBlocState) {
                                  return BlocBuilder<WatchListBloc, List<Asset>>(
                                    cubit: watchListBloc,
                                    builder: (context, assetList) {
                                      return ListView.separated(
                                        itemCount: pricesSwitcherBlocState is AssetsListLoaded ? 100 : assetList.length,
                                        addRepaintBoundaries: true,
                                        scrollDirection: Axis.vertical,
                                        physics: assetCubitState is AssetsLoadInProgress
                                            ? NeverScrollableScrollPhysics()
                                            : AlwaysScrollableScrollPhysics(),
                                        separatorBuilder: (context, int) => Divider(
                                          height: 1,
                                          color: Color(0xff646B80),
                                        ),
                                        itemBuilder: (context, index) {
                                          if (pricesSwitcherBlocState is AssetsListLoaded) {
                                            return Assets(index: index);
                                          }

                                          if (pricesSwitcherBlocState is WatchListLoaded) {
                                            if (assetList.length != 0) {
                                              return WatchList(index: index, watchListBloc: watchListBloc);
                                            }

                                            if (assetList.length == 0) {
                                              return WatchListEmpty();
                                            }
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return null;
      },
    );
  }
}
