import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAvi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      enabled: true,
      direction: ShimmerDirection.ltr,
      gradient: LinearGradient(
        colors: [
          Color(0xff303441),
          Color(0xff303441),
        ],
      ),
      child: CircleAvatar(
        radius: 19.r,
      ),
    );
  }
}
