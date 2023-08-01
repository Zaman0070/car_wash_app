import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviousOrder extends StatelessWidget {
  const PreviousOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Container(
            height: 200.h,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: appColor.withOpacity(0.05),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset('assets/icons/Group 2231.png'),
            ),
          ),
        ],
      ),
    ));
  }
}
