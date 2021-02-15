import 'package:cryptoboard/business_logic/blocs/prices_switcher/prices_switcher_bloc.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WatchListBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PricesSwitcherBloc pricesSwitcherBloc = BlocProvider.of<PricesSwitcherBloc>(context);
    return BlocBuilder<PricesSwitcherBloc, PricesSwitcherState>(
      cubit: pricesSwitcherBloc,
      builder: (context, pricesSwitcherBlocState) {
        return Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: MaterialButton(
            height: 40.0.h,
            minWidth: 0.0.w,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Color(0xff323546),
            shape: CircleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            onPressed: () {
              pricesSwitcherBloc..add(LoadWatchList());
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
            child: Center(
              child: Icon(
                pricesSwitcherBlocState is WatchListLoaded ? Icons.star : Icons.star_border,
                size: 20.0,
                color: pricesSwitcherBlocState is WatchListLoaded ? Color(0xff4878FF) : Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
