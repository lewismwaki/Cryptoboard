import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/widgets/home/quick_actions/compare/compare_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompareBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComparePage(),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Compare these Cryptoassets", style: subTitle.copyWith(fontSize: 12.0)),
          SizedBox(width: 10.0.w),
          Icon(
            Icons.arrow_forward,
            size: 22,
            color: Color(0xff4878FF),
          ),
        ],
      ),
    );
  }
}
