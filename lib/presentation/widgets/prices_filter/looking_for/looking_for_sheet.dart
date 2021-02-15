import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LookingForSheet extends StatelessWidget {
  final AssetsCubit assetsCubit;

  LookingForSheet({Key key, this.assetsCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetsCubit, AssetsState>(
      cubit: assetsCubit,
      builder: (context, state) {
        return Container(
          color: Colors.black,
          height: 224.h,
          child: ListView(
            children: [
              //title
              Container(
                color: Color(0xff23262D),
                child: ListTile(
                  title: Text(
                    'Looking For',
                    style: normalText.copyWith(color: Colors.white),
                  ),
                ),
              ),

              //rank
              ListTile(
                onTap: () {
                  Navigator.pop(context);
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
                title: Row(
                  children: [
                    Text(
                      'All Cryptocurrencies',
                      style: normalText.copyWith(color: Colors.blue),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),

              //defi tokens
              ListTile(
                onTap: () {
                  Navigator.pop(context);
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
                title: Text(
                  'Coins',
                  style: normalText,
                ),
              ),

              //full list
              ListTile(
                onTap: () {
                  Navigator.pop(context);
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
                title: Text(
                  'Tokens',
                  style: normalText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
