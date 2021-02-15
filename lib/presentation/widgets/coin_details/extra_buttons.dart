import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/widgets/home/quick_actions/compare/compare_page.dart';
import 'package:cryptoboard/presentation/widgets/home/quick_actions/convert/convert_page.dart';
import 'package:cryptoboard/presentation/widgets/home/quick_actions/price_alerts/price_alerts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExtraButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            minWidth: 0.0,
            shape: StadiumBorder(),
            elevation: 0.0,
            color: Color(0xff23262D),
            child: Text(
              'Price Alerts',
              style: assetText.copyWith(
                fontSize: 12.0.sp,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return PriceAlertsPage();
                  },
                ),
              );
            },
          ),
          MaterialButton(
            minWidth: 0.0,
            shape: StadiumBorder(),
            elevation: 0.0,
            color: Color(0xff23262D),
            child: Text(
              'Compare',
              style: assetText.copyWith(
                fontSize: 12.0.sp,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ComparePage();
                  },
                ),
              );
            },
          ),
          MaterialButton(
            minWidth: 0.0,
            shape: StadiumBorder(),
            elevation: 0.0,
            color: Color(0xff23262D),
            child: Text(
              'Converter',
              style: assetText.copyWith(
                fontSize: 12.0.sp,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ConvertPage(
                        // homeContentCubit: homeContentCubit,
                        // converterBloc: converterBloc,
                        // calculatorBloc:calculatorBloc,
                        // textFieldBloc: textFieldBloc,
                        // setPriceCubit: setPriceCubit,
                        );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
