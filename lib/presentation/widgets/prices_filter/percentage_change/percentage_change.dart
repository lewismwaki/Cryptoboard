import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/widgets/prices_filter/percentage_change/percentage_change_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PercentageChange extends StatelessWidget {
  final AssetsCubit assetsCubit;

  const PercentageChange({Key key, this.assetsCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            showModalBottomSheet(
              isDismissible: true,
              enableDrag: false,
              context: context,
              builder: (context) => PercentageChangeSheet(assetsCubit: assetsCubit),
            );
          },
          child: Text(
            '%(24h)',
            style: normalText,
          ),
        );
      },
    );
  }
}
