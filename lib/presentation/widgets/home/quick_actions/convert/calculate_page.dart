import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/calculator/calculator_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/converter/converter_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/text_field/text_field_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/set_price/set_price_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/search/select_first_currency.dart';
import 'package:cryptoboard/presentation/pages/search/select_second_currency.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'calculator_section.dart';
import 'compare_btn.dart';

class CalculatePage extends StatelessWidget {
  final HomeContentCubit homeContentCubit;
  final TextFieldBloc textFieldBloc;
  final ConverterBloc converterBloc;
  final SetPriceCubit setPriceCubit;
  final priceOneIcon;
  final priceOneSymbol;
  final priceOnePrice;
  final priceTwoPrice;
  final priceOneName;
  final priceTwoSymbol;
  final priceTwoName;
  final priceTwoIcon;
  final CalculatorBloc calculatorBloc;
  const CalculatePage({
    Key key,
    this.setPriceCubit,
    this.textFieldBloc,
    this.calculatorBloc,
    this.homeContentCubit,
    this.converterBloc,
    this.priceOneIcon,
    this.priceOneSymbol,
    this.priceOnePrice,
    this.priceTwoPrice,
    this.priceTwoSymbol,
    this.priceTwoName,
    this.priceTwoIcon,
    this.priceOneName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController priceOneTextController = TextEditingController();
    TextEditingController priceTwoTextController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0.0,
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
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          title: Text('Currency Converter', style: appBarText.copyWith(fontSize: 14.0)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //text field one
            GestureDetector(
              onTap: () {
                textFieldBloc..add(TapTextFieldOne());
              },
              child: BlocBuilder<TextFieldBloc, TextFieldState>(
                cubit: textFieldBloc,
                builder: (context, state) {
                  //things to do or show when text field one is tapped
                  if (state is TextFieldOneTapped) {
                    print('text field one tapped');
                    return Container(
                      color: Color(0xff171924),
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0.w, top: 20.0.h, bottom: 20.0.h, left: 16.0.w),
                        child: BlocBuilder<SetPriceCubit, SetPriceState>(
                          cubit: setPriceCubit,
                          builder: (context, state) {
                            //things to do or show when price is not yet set

                            if (state is SetPriceInitial) {
                              print('state is initial');

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
                                      print("state initial resultOne 0: ${resultOne[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              priceOneIcon: resultOne[0].toString(),
                                              priceOneName: resultOne[1],
                                              priceOneSymbol: resultOne[2],
                                              priceOnePrice: resultOne[3],
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
                                        Text('Tether', style: assetText.copyWith(fontSize: 12.0)),
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
                                              '9I01',
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
                                              'ASF',
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              'ASDF',
                                              style: subTitle,
                                            ),
                                          ],
                                        );
                                    },
                                  ),
                                ],
                              );
                            }
                            //things to do or show when price one is set

                            else if (state is SetPriceOneSuccess) {
                              print('price one set; when text field one is tapped & price chosesn');

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
                                          builder: (context) =>  SelectFirstCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );

                                      final resultTwo = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>  SelectSecondCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultTwo 0: ${resultTwo[0]}");

                                      // Navigator.of(context).pushReplacement(
                                      //   MaterialPageRoute(
                                      //     builder: (BuildContext context) {
                                      //       return CalculatePage(
                                      //         // priceOneIcon: '',
                                      //         // priceOneName: '',
                                      //         // priceOneSymbol: '',
                                      //         // priceOnePrice: '',
                                      //         priceTwoIcon: resultTwo[0],
                                      //         priceTwoName: resultTwo[1],
                                      //         priceTwoSymbol: resultTwo[2],
                                      //         priceTwoPrice: resultTwo[3],
                                      //         homeContentCubit: homeContentCubit,
                                      //         setPriceCubit: setPriceCubit,
                                      //         calculatorBloc: calculatorBloc,
                                      //         converterBloc: converterBloc,
                                      //         textFieldBloc: textFieldBloc,
                                      //       );
                                      //     },
                                      //   ),
                                      // );
                                      print("state initial resultOne 0: ${resultOne[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              priceOneIcon: resultOne[0].toString(),
                                              priceOneName: resultOne[1],
                                              priceOneSymbol: resultOne[2],
                                              priceOnePrice: resultOne[3],
                                              priceTwoIcon: resultTwo[0],
                                              priceTwoName: resultTwo[1],
                                              priceTwoSymbol: resultTwo[2],
                                              priceTwoPrice: resultTwo[3],
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
                                              imageUrl: 'https://icons.bitbot.tools/api/${priceOneSymbol.toString()}/64x64',
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.h),
                                        Text(
                                          priceOneSymbol.toString(),
                                          style: assetText.copyWith(fontSize: 12.0),
                                        ),
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
                                              priceOneName.toString(),
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
                                              priceOnePrice.toString(),
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceOneName.toString(),
                                              style: subTitle,
                                            ),
                                          ],
                                        );
                                    },
                                  ),
                                ],
                              );
                            }
                            //things to do or show when price two is set

                            else if (state is SetPriceTwoSuccess) {
                              print('price two set; when text field one is tapped & price chosesn');
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

                                          builder: (context) =>  SelectFirstCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultOne 0: ${resultOne[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              priceOneIcon: resultOne[0].toString(),
                                              priceOneName: resultOne[1],
                                              priceOneSymbol: resultOne[2],
                                              priceOnePrice: resultOne[3],
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
                                              imageUrl: 'https://icons.bitbot.tools/api/${priceOneSymbol.toString()}/64x64',
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.h),
                                        Text(
                                          priceOneSymbol.toString(),
                                          style: assetText.copyWith(fontSize: 12.0),
                                        ),
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
                                              priceOneName.toString(),
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
                                              priceOnePrice.toString(),
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceOneName.toString(),
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

                                      final resultOne = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SelectFirstCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultOne 0: ${resultOne[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              priceOneIcon: resultOne[0].toString(),
                                              priceOneName: resultOne[1],
                                              priceOneSymbol: resultOne[2],
                                              priceOnePrice: resultOne[3],
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
                                        Text("USDT", style: assetText.copyWith(fontSize: 12.0)),
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
                                              'Tether',
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
                                              '089',
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              "Tether",
                                              style: subTitle,
                                            ),
                                          ],
                                        );
                                    },
                                  ),
                                ],
                              );
                              //things to do or show when price one is set
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
                                          builder: (context) =>  SelectFirstCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultOne 0: ${resultOne[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              priceOneIcon: resultOne[0].toString(),
                                              priceOneName: resultOne[1],
                                              priceOneSymbol: resultOne[2],
                                              priceOnePrice: resultOne[3],
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
                                              imageUrl: 'https://icons.bitbot.tools/api/${priceOneSymbol.toString()}/64x64',
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.h),
                                        Text(
                                          priceOneSymbol.toString(),
                                          style: assetText.copyWith(fontSize: 12.0),
                                        ),
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
                                              priceOneName.toString(),
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
                                              priceOnePrice.toString(),
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceOneName.toString(),
                                              style: subTitle,
                                            ),
                                          ],
                                        );
                                    },
                                  ),
                                ],
                              );
                              //things to do or show when price two is set
                            } else if (state is SetPriceTwoSuccess) {
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
                                          builder: (context) =>  SelectFirstCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultOne 0: ${resultOne[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              priceOneIcon: resultOne[0].toString(),
                                              priceOneName: resultOne[1],
                                              priceOneSymbol: resultOne[2],
                                              priceOnePrice: resultOne[3],
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
                                              imageUrl: 'https://icons.bitbot.tools/api/${priceOneSymbol.toString()}/64x64',
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.h),
                                        Text(
                                          priceOneSymbol.toString(),
                                          style: assetText.copyWith(fontSize: 12.0),
                                        ),
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
                                              priceOneName.toString(),
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
                                              priceOnePrice.toString(),
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceOneName.toString(),
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
            ),

            //text field two
            GestureDetector(
              onTap: () {
                textFieldBloc..add(TapTextFieldTwo());
              },
              child: BlocBuilder<TextFieldBloc, TextFieldState>(
                cubit: textFieldBloc,
                builder: (context, state) {
                  //things to do or show when  text field two is tapped
                  if (state is TextFieldTwoTapped) {
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
                                      setPriceCubit.setPriceTwo();

                                      final resultTwo = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>  SelectSecondCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultTwo 0: ${resultTwo[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              // priceOneIcon: '',
                                              // priceOneName: '',
                                              // priceOneSymbol: '',
                                              // priceOnePrice: '',
                                              priceTwoIcon: resultTwo[0],
                                              priceTwoName: resultTwo[1],
                                              priceTwoSymbol: resultTwo[2],
                                              priceTwoPrice: resultTwo[3],
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
                                        Text(
                                          'USDT',
                                          style: assetText.copyWith(fontSize: 12.0),
                                        ),
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
                                                controller: priceTwoTextController,
                                                style: TextStyle(
                                                  fontSize: 23.0.ssp,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              'Tether',
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
                                              '099',
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              'pricetring()',
                                              style: subTitle,
                                            ),
                                          ],
                                        );
                                    },
                                  ),
                                ],
                              );
                            } else
                            //things to do or show when price one is set
                            if (state is SetPriceOneSuccess) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //asset
                                  GestureDetector(
                                    onTap: () async {
                                      setPriceCubit.setPriceTwo();

                                      final resultTwo = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>  SelectSecondCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultTwo 0: ${resultTwo[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              // priceOneIcon: '',
                                              // priceOneName: '',
                                              // priceOneSymbol: '',
                                              // priceOnePrice: '',
                                              priceTwoIcon: resultTwo[0],
                                              priceTwoName: resultTwo[1],
                                              priceTwoSymbol: resultTwo[2],
                                              priceTwoPrice: resultTwo[3],
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
                                              imageUrl: 'https://icons.bitbot.tools/api/${priceTwoSymbol.toString()}/64x64',
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.h),
                                        Text(priceTwoSymbol.toString(), style: assetText.copyWith(fontSize: 12.0)),
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
                                                controller: priceTwoTextController,
                                                style: TextStyle(
                                                  fontSize: 23.0.ssp,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceTwoName.toString(),
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
                                              priceTwoPrice.toString(),
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceTwoName.toString(),
                                              style: subTitle,
                                            ),
                                          ],
                                        );
                                    },
                                  ),
                                ],
                              );
                            } else if (state is SetPriceTwoSuccess) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //asset
                                  GestureDetector(
                                    onTap: () async {
                                      setPriceCubit.setPriceTwo();

                                      final resultTwo = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>  SelectSecondCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultTwo 0: ${resultTwo[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              // priceOneIcon: '',
                                              // priceOneName: '',
                                              // priceOneSymbol: '',
                                              // priceOnePrice: '',
                                              priceTwoIcon: resultTwo[0],
                                              priceTwoName: resultTwo[1],
                                              priceTwoSymbol: resultTwo[2],
                                              priceTwoPrice: resultTwo[3],
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
                                              imageUrl: 'https://icons.bitbot.tools/api/${priceTwoSymbol.toString()}/64x64',
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.h),
                                        Text(priceTwoSymbol.toString(), style: assetText.copyWith(fontSize: 12.0)),
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
                                                controller: priceTwoTextController,
                                                style: TextStyle(
                                                  fontSize: 23.0.ssp,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceTwoName.toString(),
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
                                              priceTwoPrice.toString(),
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceTwoName.toString(),
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
                  } else
                    //things to do or show when text field two is not tapped
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
                                      setPriceCubit.setPriceTwo();
                                      final resultTwo = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SelectSecondCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultTwo 0: ${resultTwo[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              // priceOneIcon: '',
                                              // priceOneName: '',
                                              // priceOneSymbol: '',
                                              // priceOnePrice: '',
                                              priceTwoIcon: resultTwo[0],
                                              priceTwoName: resultTwo[1],
                                              priceTwoSymbol: resultTwo[2],
                                              priceTwoPrice: resultTwo[3],
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
                                        Text('Tether', style: assetText.copyWith(fontSize: 12.0)),
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
                                                controller: priceTwoTextController,
                                                style: TextStyle(
                                                  fontSize: 23.0.ssp,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              'Tether',
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
                                              '1028',
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
                            //things to do or show when price one is set
                            if (state is SetPriceOneSuccess) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //asset
                                  GestureDetector(
                                    onTap: () async {
                                      setPriceCubit.setPriceTwo();

                                      final resultTwo = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>  SelectSecondCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultTwo 0: ${resultTwo[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              // priceOneIcon: '',
                                              // priceOneName: '',
                                              // priceOneSymbol: '',
                                              // priceOnePrice: '',
                                              priceTwoIcon: resultTwo[0],
                                              priceTwoName: resultTwo[1],
                                              priceTwoSymbol: resultTwo[2],
                                              priceTwoPrice: resultTwo[3],
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
                                              imageUrl: 'https://icons.bitbot.tools/api/${priceTwoSymbol.toString()}/64x64',
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.h),
                                        Text(priceTwoSymbol.toString(), style: assetText.copyWith(fontSize: 12.0)),
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
                                                controller: priceTwoTextController,
                                                style: TextStyle(
                                                  fontSize: 23.0.ssp,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceTwoName.toString(),
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
                                              priceTwoPrice.toString(),
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceTwoName.toString(),
                                              style: subTitle,
                                            ),
                                          ],
                                        );
                                    },
                                  ),
                                ],
                              );
                            } else if (state is SetPriceTwoSuccess) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //asset
                                  GestureDetector(
                                    onTap: () async {
                                      setPriceCubit.setPriceTwo();

                                      final resultTwo = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>  SelectSecondCurrency(
                                            homeContentCubit: homeContentCubit,
                                            setPriceCubit: setPriceCubit,
                                          ),
                                        ),
                                      );
                                      print("state initial resultTwo 0: ${resultTwo[0]}");

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CalculatePage(
                                              // priceOneIcon: '',
                                              // priceOneName: '',
                                              // priceOneSymbol: '',
                                              // priceOnePrice: '',
                                              priceTwoIcon: resultTwo[0],
                                              priceTwoName: resultTwo[1],
                                              priceTwoSymbol: resultTwo[2],
                                              priceTwoPrice: resultTwo[3],
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
                                              imageUrl: 'https://icons.bitbot.tools/api/${priceTwoSymbol.toString()}/64x64',
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.h),
                                        Text(priceTwoSymbol.toString(), style: assetText.copyWith(fontSize: 12.0)),
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
                                                controller: priceTwoTextController,
                                                style: TextStyle(
                                                  fontSize: 23.0.ssp,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceTwoName.toString(),
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
                                              priceTwoPrice.toString(),
                                              style: TextStyle(
                                                fontSize: 23.0.ssp,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xffA1A7BB),
                                              ),
                                            ),
                                            SizedBox(height: 6.0.h),
                                            Text(
                                              priceTwoName.toString(),
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
            ),

            SizedBox(height: 16.0.h),

            // compare these crypto assets
            CompareBtn(),

            //calculator
            CalculatorSection(
              priceOneTextController: priceOneTextController,
              priceTwoTextController: priceTwoTextController,
              textFieldBloc: textFieldBloc,
              converterBloc: converterBloc,
              calculatorBloc: calculatorBloc,
            ),
          ],
        ),
      ),
    );
  }
}

