import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomeWalletBox extends StatelessWidget {
  Function() address;
  String walletBalance;
   HomeWalletBox({super.key, required this.address, required this.walletBalance});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'موقعك الحالي',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'الرياض',
              style: TextStyle(fontSize: 16.sp, color: appColor),
            ),
            SizedBox(
              width: 5.w,
            ),
            InkWell(
              onTap: address,
              child: CircleAvatar(
                radius: 9.h,
                backgroundColor: appColor,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, right: 5, top: 4),
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 12.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
            height: 32.h,
            width: 90.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appColor.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    AppImage.wallet,
                    height: 15.h,
                    color: appColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    walletBalance,
                    style: TextStyle(fontSize: 14.sp, color: appColor),
                  ),
                  Text(
                    'ريال',
                    style: TextStyle(fontSize: 13.sp, color: appColor),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
