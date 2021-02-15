import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/set_price/set_price_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/search/search_cryptoassets.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supercharged/supercharged.dart';

class SelectFirstCurrency extends StatelessWidget {
  final HomeContentCubit homeContentCubit;
  final SetPriceCubit setPriceCubit;
  const SelectFirstCurrency({
    Key key,
    this.setPriceCubit,
    this.homeContentCubit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              visualDensity: VisualDensity.compact,
              splashRadius: 20.w,
              padding: EdgeInsets.all(0),
              hoverColor: Color(0xff2777FF).withAlpha(80),
              splashColor: Color(0xff2777FF).withAlpha(80),
              highlightColor: Color(0xff2777FF).withAlpha(80),
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('Select First Currency', style: appBarText.copyWith(fontSize: 16.0.sp)),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xff858CA2),
                ),
                onPressed: () {
                  showSearch(context: context, delegate: SearchCryptoassets(homeContentCubit: homeContentCubit));
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //title
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 16.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'All Cryptoassets',
                        style: titleText.copyWith(fontSize: 16.0.sp),
                      ),
                      //title
                    ],
                  ),
                ),

                BlocBuilder<HomeContentCubit, HomeContentState>(
                  cubit: homeContentCubit,
                  builder: (context, homeContentCubitState) {
                    if (homeContentCubitState is HomeContentLoadSuccess) {
                      return Container(
                        height: 1.sh,
                        child: BlocBuilder<SetPriceCubit, SetPriceState>(
                          cubit: setPriceCubit,
                          builder: (context, setPriceCubitState) {
                            return ListView.separated(
                              itemCount: 100,
                              separatorBuilder: (context, int) => Divider(
                                height: 1,
                                color: Color(0xff646B80),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final assetClass = homeContentCubitState.assetsClass.data;
                                final sortedByRankAscending = assetClass.sortedByNum((element) => double.parse(element.rank));
                                final asset = sortedByRankAscending[index];

                                final icon = asset.symbol.toLowerCase();

                                final priceOneName = asset.name;
                                final priceOneIcon = icon;
                                final priceOneSymbol = asset.symbol;
                                final priceOnePrice = asset.priceUsd;
                                // final priceTwoName = asset.name;
                                // final priceTwoIcon = icon;
                                //
                                // final priceTwoSymbol = asset.symbol;
                                // final priceTwoPrice = asset.priceUsd;

                                List<Map<String, dynamic>> details = [
                                  // setPriceCubitState is SetPriceOneSuccess
                                  //     ?
                                  {
                                    "priceOneIcon": priceOneIcon,
                                    'priceOneName': priceOneName,
                                    'priceOneSymbol': priceOneSymbol,
                                    "priceOnePrice": priceOnePrice,
                                  }

                                  // : setPriceCubitState is SetPriceTwoSuccess
                                  //     ? {
                                  //         "priceTwoIcon": priceTwoIcon,
                                  //         'priceTwoName': priceTwoName,
                                  //         'priceTwoSymbol': priceTwoSymbol,
                                  //         "priceTwoPrice": priceTwoPrice,
                                  //       }
                                  //     : null,
                                ];

                                return Theme(
                                  data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context, [
                                        details[0]['priceOneIcon'],
                                        details[0]['priceOneName'],
                                        details[0]['priceOneSymbol'],
                                        details[0]['priceOnePrice'],
                                      ]);
                                      // : setPriceCubitState is SetPriceTwoSuccess
                                      //     ? Navigator.pop(context, [
                                      //         details[0]['priceTwoIcon'],
                                      //         details[0]['priceTwoName'],
                                      //         details[0]['priceTwoSymbol'],
                                      //         details[0]['priceTwoPrice'],
                                      //       ])
                                      //     : null;
                                    },

                                    leading: CircleAvatar(
                                      radius: 18,
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
                                    // trailing: ,
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
                            );
                          },
                        ),
                      );
                    } else
                      return null;
                  },
                ),

                //
              ],
            ),
          )
        ],
      ),
    );
  }
}
