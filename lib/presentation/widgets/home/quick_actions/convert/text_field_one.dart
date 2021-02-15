import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/calculator/calculator_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/converter/converter_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/text_field/text_field_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/set_price/set_price_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/search/select_first_currency.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'calculate_page.dart';

class TextFieldOne extends StatelessWidget {
  final CalculatorBloc calculatorBloc;
  final TextFieldBloc textFieldBloc;
  final HomeContentCubit homeContentCubit;
  final ConverterBloc converterBloc;
  final String priceOneName;
  final String priceOneSymbol;
  final String priceOnePrice;
  final String priceOneIcon;
  final TextEditingController priceOneTextController;
  final SetPriceCubit setPriceCubit;
  TextFieldOne({
    Key key,
    this.setPriceCubit,
    this.textFieldBloc,
    this.priceOneTextController,
    this.homeContentCubit,
    this.calculatorBloc,
    this.priceOneName,
    this.priceOneIcon,
    this.priceOneSymbol,
    this.converterBloc,
    this.priceOnePrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        textFieldBloc..add(TapTextFieldOne());
      },
      child: BlocBuilder<TextFieldBloc, TextFieldState>(
        cubit: textFieldBloc,
        builder: (context, state) {
          //things to do or show when text field one is tapped
          if (state is TextFieldOneTapped) {
            return Container(
              color: Color(0xff171924),
              child: Padding(
                padding: EdgeInsets.only(right: 16.0.w, top: 20.0.h, bottom: 20.0.h, left: 16.0.w),
                child: BlocBuilder<SetPriceCubit, SetPriceState>(
                  cubit: setPriceCubit,
                  builder: (context, state) {
                    //things to do or show when price is not yet set
                    if (state is SetPriceInitial) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //asset
                          GestureDetector(
                            onTap: () async {
                              setPriceCubit.setPriceOne();
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SelectFirstCurrency(
                                    homeContentCubit: homeContentCubit,
                                    setPriceCubit: setPriceCubit,
                                  ),
                                ),
                              );
                              print("state initial result 0: ${result[0]}");
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CalculatePage(
                                      priceOneIcon: result[0].toString(),
                                      priceOneName: result[1],
                                      priceOneSymbol: result[2],
                                      priceOnePrice: result[3],
                                      // priceTwoIcon: "",
                                      // priceTwoName: "",
                                      // priceTwoSymbol: "",
                                      // priceTwoPrice: "",
                                      homeContentCubit: homeContentCubit,
                                      setPriceCubit: setPriceCubit,
                                      calculatorBloc: calculatorBloc,
                                      converterBloc: converterBloc,
                                      textFieldBloc: textFieldBloc,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.black,
                                  child: Container(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      placeholder: (BuildContext, String) => ShimmerAvi(),
                                      imageUrl: 'https://icons.bitbot.tools/api/usdt/64x64',
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0.h),
                                Text('USDT', style: assetText.copyWith(fontSize: 12.0)),
                              ],
                            ),
                          ),

                          BlocBuilder<CalculatorBloc, CalculatorState>(
                            cubit: calculatorBloc,
                            builder: (context, state) {
                              if (state is AddedNumberSuccess) {
                                print('asdfaasdffafassdf');
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20.0.h,
                                      width: 286.0.w,
                                      child: TextField(
                                        showCursor: true,
                                        maxLines: 1,
                                        enabled: false,
                                        minLines: 1,
                                        decoration: InputDecoration(
                                          hintText: '1.0000',
                                          counterText: '',
                                          contentPadding: EdgeInsets.only(bottom: 8.0.h),
                                          hintStyle: TextStyle(
                                            fontSize: 23.0.ssp,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xffA1A7BB),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.end,
                                        cursorColor: Colors.white,
                                        controller: priceOneTextController,
                                        style: TextStyle(
                                          fontSize: 23.0.ssp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6.0.h),
                                    Text(
                                      "Tether",
                                      style: subTitle,
                                    ),
                                  ],
                                );
                              } else
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 23.0.ssp,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xffA1A7BB),
                                      ),
                                    ),
                                    SizedBox(height: 6.0.h),
                                    Text(
                                      'Tether',
                                      style: subTitle,
                                    ),
                                  ],
                                );
                            },
                          ),
                        ],
                      );
                      //workaround to hide error during transition
                    } else if (state is SetPriceOneSuccess) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //asset
                          GestureDetector(
                            onTap: () async {
                              setPriceCubit.setPriceOne();

                              final resultOne = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SelectFirstCurrency(
                                    homeContentCubit: homeContentCubit,
                                    setPriceCubit: setPriceCubit,
                                  ),
                                ),
                              );
                              print("state initial result 0: ${resultOne[0]}");
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CalculatePage(
                                      priceOneIcon: resultOne[0].toString(),
                                      priceOneName: resultOne[1],
                                      priceOneSymbol: resultOne[2],
                                      priceOnePrice: resultOne[3],
                                      // priceTwoIcon: result[4],
                                      // priceTwoName: result[5],
                                      // priceTwoSymbol: result[6],
                                      // priceTwoPrice: result[7],
                                      homeContentCubit: homeContentCubit,
                                      setPriceCubit: setPriceCubit,
                                      calculatorBloc: calculatorBloc,
                                      converterBloc: converterBloc,
                                      textFieldBloc: textFieldBloc,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.black,
                                  child: Container(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      placeholder: (BuildContext, String) => ShimmerAvi(),
                                      imageUrl: 'https://icons.bitbot.tools/api/usdt/64x64',
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0.h),
                                Text('USDT', style: assetText.copyWith(fontSize: 12.0)),
                              ],
                            ),
                          ),

                          BlocBuilder<CalculatorBloc, CalculatorState>(
                            cubit: calculatorBloc,
                            builder: (context, state) {
                              if (state is AddedNumberSuccess) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20.0.h,
                                      width: 286.0.w,
                                      child: TextField(
                                        showCursor: true,
                                        maxLines: 1,
                                        enabled: false,
                                        minLines: 1,
                                        decoration: InputDecoration(
                                          hintText: '1.0000',
                                          counterText: '',
                                          contentPadding: EdgeInsets.only(bottom: 8.0.h),
                                          hintStyle: TextStyle(
                                            fontSize: 23.0.ssp,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xffA1A7BB),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.end,
                                        cursorColor: Colors.white,
                                        controller: priceOneTextController,
                                        style: TextStyle(
                                          fontSize: 23.0.ssp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6.0.h),
                                    Text(
                                      "Tether",
                                      style: subTitle,
                                    ),
                                  ],
                                );
                              } else
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 23.0.ssp,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xffA1A7BB),
                                      ),
                                    ),
                                    SizedBox(height: 6.0.h),
                                    Text(
                                      'Tether',
                                      style: subTitle,
                                    ),
                                  ],
                                );
                            },
                          ),
                        ],
                      );
                    } else
                      return null;
                  },
                ),
              ),
            );
          }
          //things to do or show when text field one is not tapped
          else
            return Container(
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.only(right: 16.0.w, top: 20.0.h, bottom: 20.0.h, left: 16.0.w),
                child: BlocBuilder<SetPriceCubit, SetPriceState>(
                  cubit: setPriceCubit,
                  builder: (context, state) {
                    //things to do or show when price is not yet set
                    if (state is SetPriceInitial) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //asset
                          GestureDetector(
                            onTap: () async {
                              setPriceCubit.setPriceOne();
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SelectFirstCurrency(
                                    homeContentCubit: homeContentCubit,
                                    setPriceCubit: setPriceCubit,
                                  ),
                                ),
                              );
                              print("state initial result 0: ${result[0]}");
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CalculatePage(
                                      priceOneIcon: result[0].toString(),
                                      priceOneName: result[1],
                                      priceOneSymbol: result[2],
                                      priceOnePrice: result[3],
                                      // priceTwoIcon: result[4],
                                      // priceTwoName: result[5],
                                      // priceTwoSymbol: result[6],
                                      // priceTwoPrice: result[7],
                                      homeContentCubit: homeContentCubit,
                                      setPriceCubit: setPriceCubit,
                                      calculatorBloc: calculatorBloc,
                                      converterBloc: converterBloc,
                                      textFieldBloc: textFieldBloc,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.black,
                                  child: Container(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      placeholder: (BuildContext, String) => ShimmerAvi(),
                                      imageUrl: 'https://icons.bitbot.tools/api/usdt/64x64',
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0.h),
                                Text('USDT', style: assetText.copyWith(fontSize: 12.0)),
                              ],
                            ),
                          ),

                          BlocBuilder<CalculatorBloc, CalculatorState>(
                            cubit: calculatorBloc,
                            builder: (context, state) {
                              if (state is AddedNumberSuccess) {
                                print("afsdfsdf");
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20.0.h,
                                      width: 286.0.w,
                                      child: TextField(
                                        showCursor: true,
                                        maxLines: 1,
                                        enabled: false,
                                        minLines: 1,
                                        decoration: InputDecoration(
                                          hintText: '1.0000',
                                          counterText: '',
                                          contentPadding: EdgeInsets.only(bottom: 8.0.h),
                                          hintStyle: TextStyle(
                                            fontSize: 23.0.ssp,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xffA1A7BB),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.end,
                                        cursorColor: Colors.white,
                                        controller: priceOneTextController,
                                        style: TextStyle(
                                          fontSize: 23.0.ssp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6.0.h),
                                    Text(
                                      "Tether",
                                      style: subTitle,
                                    ),
                                  ],
                                );
                              } else
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 23.0.ssp,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xffA1A7BB),
                                      ),
                                    ),
                                    SizedBox(height: 6.0.h),
                                    Text(
                                      'Tether',
                                      style: subTitle,
                                    ),
                                  ],
                                );
                            },
                          ),
                        ],
                      );
                      //workaround to hide error during transition

                    } else if (state is SetPriceOneSuccess) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //asset
                          GestureDetector(
                            onTap: () async {
                              setPriceCubit.setPriceOne();

                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SelectFirstCurrency(
                                    homeContentCubit: homeContentCubit,
                                    setPriceCubit: setPriceCubit,
                                  ),
                                ),
                              );
                              print("state initial result 0: ${result[0]}");
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CalculatePage(
                                      priceOneIcon: result[0].toString(),
                                      priceOneName: result[1],
                                      priceOneSymbol: result[2],
                                      priceOnePrice: result[3],
                                      // priceTwoIcon: result[4],
                                      // priceTwoName: result[5],
                                      // priceTwoSymbol: result[6],
                                      // priceTwoPrice: result[7],
                                      homeContentCubit: homeContentCubit,
                                      setPriceCubit: setPriceCubit,
                                      calculatorBloc: calculatorBloc,
                                      converterBloc: converterBloc,
                                      textFieldBloc: textFieldBloc,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.black,
                                  child: Container(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      placeholder: (BuildContext, String) => ShimmerAvi(),
                                      imageUrl: 'https://icons.bitbot.tools/api/usdt/64x64',
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0.h),
                                Text('USDT', style: assetText.copyWith(fontSize: 12.0)),
                              ],
                            ),
                          ),

                          BlocBuilder<CalculatorBloc, CalculatorState>(
                            cubit: calculatorBloc,
                            builder: (context, state) {
                              if (state is AddedNumberSuccess) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20.0.h,
                                      width: 286.0.w,
                                      child: TextField(
                                        showCursor: true,
                                        maxLines: 1,
                                        enabled: false,
                                        minLines: 1,
                                        decoration: InputDecoration(
                                          hintText: '1.0000',
                                          counterText: '',
                                          contentPadding: EdgeInsets.only(bottom: 8.0.h),
                                          hintStyle: TextStyle(
                                            fontSize: 23.0.ssp,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xffA1A7BB),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.end,
                                        cursorColor: Colors.white,
                                        controller: priceOneTextController,
                                        style: TextStyle(
                                          fontSize: 23.0.ssp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6.0.h),
                                    Text(
                                      "Tether",
                                      style: subTitle,
                                    ),
                                  ],
                                );
                              } else
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 23.0.ssp,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xffA1A7BB),
                                      ),
                                    ),
                                    SizedBox(height: 6.0.h),
                                    Text(
                                      'Tether',
                                      style: subTitle,
                                    ),
                                  ],
                                );
                            },
                          ),
                        ],
                      );
                    } else
                      return null;
                  },
                ),
              ),
            );
        },
      ),
    );
  }
}
