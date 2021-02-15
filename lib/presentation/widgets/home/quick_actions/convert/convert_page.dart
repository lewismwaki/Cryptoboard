import 'package:cryptoboard/business_logic/blocs/calculator/calculator_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/converter/converter_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/text_field/text_field_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/set_price/set_price_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'calculator_section.dart';
import 'compare_btn.dart';
import 'text_field_one.dart';
import 'text_field_two.dart';

class ConvertPage extends StatelessWidget {
  final HomeContentCubit homeContentCubit;
  final TextFieldBloc textFieldBloc;
  final ConverterBloc converterBloc;
  final SetPriceCubit setPriceCubit;
  final String priceOneIcon;
  final String priceOneName;
  final String priceOneSymbol;
  final String priceOnePrice;
  final String priceTwoPrice;

  final String priceTwoSymbol;
  final String priceTwoName;
  final String priceTwoIcon;
  final CalculatorBloc calculatorBloc;
  const ConvertPage({
    Key key,
    this.setPriceCubit,
    this.textFieldBloc,
    this.calculatorBloc,
    this.homeContentCubit,
    this.converterBloc,
    this.priceOneIcon,
    this.priceOneName,
    this.priceOneSymbol,
    this.priceOnePrice,
    this.priceTwoPrice,
    this.priceTwoSymbol,
    this.priceTwoName,
    this.priceTwoIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          title: Text('Currency Converter', style: appBarText.copyWith(fontSize: 16.0,),),
        ),
        body: BlocBuilder<CalculatorBloc, CalculatorState>(
          cubit: calculatorBloc,
          builder: (context, state) {
            TextEditingController priceOneTextController = TextEditingController();
            TextEditingController priceTwoTextController = TextEditingController();
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //text field
                TextFieldOne(
                  priceOneTextController: priceOneTextController,
                  textFieldBloc: textFieldBloc,
                  converterBloc: converterBloc,
                  priceOnePrice: priceOnePrice,
                  priceOneIcon: priceOneIcon,
                  priceOneName: priceOneName,
                  priceOneSymbol: priceOneSymbol,
                  homeContentCubit: homeContentCubit,
                  setPriceCubit: setPriceCubit,
                  calculatorBloc: calculatorBloc,
                ),
                TextFieldTwo(
                  priceTwoTextController: priceTwoTextController,
                  textFieldBloc: textFieldBloc,
                  converterBloc: converterBloc,
                  priceTwoPrice: priceTwoPrice,
                  priceTwoName: priceTwoName,
                  priceTwoIcon: priceTwoIcon,
                  homeContentCubit: homeContentCubit,
                  setPriceCubit: setPriceCubit,
                  priceTwoSymbol: priceTwoSymbol,
                  calculatorBloc: calculatorBloc,
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
            );
          },
        ),
      ),
    );
  }
}
