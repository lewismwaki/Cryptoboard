import 'package:cryptoboard/business_logic/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/calculator/calculator_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/converter/converter_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/prices_switcher/prices_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/text_field/text_field_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/set_price/set_price_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:cryptoboard/presentation/widgets/home/quick_actions/convert/convert_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'compare/compare_page.dart';
import 'price_alerts/price_alerts_page.dart';

class QuickActions extends StatefulWidget {
  final ConverterBloc converterBloc;
  final CalculatorBloc calculatorBloc;
  final TextFieldBloc textFieldBloc;
  final SetPriceCubit setPriceCubit;
  final HomeContentCubit homeContentCubit;
  const QuickActions({
    Key key,
    this.setPriceCubit,
    this.calculatorBloc,
    this.homeContentCubit,
    this.converterBloc,
    this.textFieldBloc,
  }) : super(key: key);

  @override
  _QuickActionsState createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 161.h,
      width: 1.sw,
      child: Column(
        children: [
          //chips
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
            child: Container(
              height: 129.h,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price alerts
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return PriceAlertsPage();
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0.w, bottom: 8.0.h),
                          child: Container(
                            height: 60.h,
                            width: 187.w,
                            decoration: BoxDecoration(
                              color: Color(0xff222531),
                              borderRadius: BorderRadius.circular(18.w),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
                              child: Row(
                                children: [
                                  //icon
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0.w),
                                    child: Container(
                                      height: 38.h,
                                      width: 38.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xff23DCF5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.album,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // text
                                  Text(
                                    'Price Alerts',
                                    style: quickActionText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //convert
                      GestureDetector(
                        onTap: () {
                          widget.converterBloc..add(LoadConverter());
                          widget.setPriceCubit.LoadPriceInitial();
                          showCustomNotification(
                            title: 'Feature still in development',
                            subtitle: 'Be sure to check after subsequent releases',
                            icon: MdiIcons.beta,
                            iconColor: Colors.white,
                            iconBackgroundColor: Color(0xff555E8D),
                            seconds: 3,
                            padding: EdgeInsets.only(top: 8.0.h),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ConvertPage(
                                  homeContentCubit: widget.homeContentCubit,
                                  converterBloc: widget.converterBloc,
                                  calculatorBloc: widget.calculatorBloc,
                                  textFieldBloc: widget.textFieldBloc,
                                  setPriceCubit: widget.setPriceCubit,
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0.w),
                          child: Container(
                            height: 60.h,
                            width: 187.w,
                            decoration: BoxDecoration(
                              color: Color(0xff222531),
                              borderRadius: BorderRadius.circular(18.w),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
                              child: Row(
                                children: [
                                  //icon
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0.w),
                                    child: Container(
                                      height: 38.h,
                                      width: 38.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xff3861FB),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        MdiIcons.calculator,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // text
                                  Text('Convert', style: quickActionText),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //compare
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ComparePage();
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.0.h),
                          child: Container(
                            height: 60.h,
                            width: 187.w,
                            decoration: BoxDecoration(
                              color: Color(0xff222531),
                              borderRadius: BorderRadius.circular(18.w),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
                              child: Row(
                                children: [
                                  //icon
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0.w),
                                    child: Container(
                                      height: 38.h,
                                      width: 38.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF35BB6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        MdiIcons.compare,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // text
                                  Text(
                                    'Compare',
                                    style: quickActionText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //watchlist
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<BottomNavBarBloc>(context)..add(LoadPricesPage());
                          BlocProvider.of<PricesSwitcherBloc>(context)..add(LoadWatchList());
                        },
                        child: Container(
                          height: 60.h,
                          width: 187.w,
                          decoration: BoxDecoration(
                            color: Color(0xff222531),
                            borderRadius: BorderRadius.circular(18.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
                            child: Row(
                              children: [
                                //icon
                                Padding(
                                  padding: EdgeInsets.only(right: 15.0.w),
                                  child: Container(
                                    height: 38.h,
                                    width: 38.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xff8A3FFC),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                // text
                                Text(
                                  'Watchlist',
                                  style: quickActionText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
