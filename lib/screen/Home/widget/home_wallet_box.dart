import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/Home/view/add_walet_balance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeWalletBox extends StatefulWidget {
  Function() address;
  HomeWalletBox({
    super.key,
    required this.address,
  });

  @override
  State<HomeWalletBox> createState() => _HomeWalletBoxState();
}

class _HomeWalletBoxState extends State<HomeWalletBox> {
  String cityname = '';
  int waletBalance = 0;
  void getCurrentLocation() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          cityname = element['cityName'];
          waletBalance = element['walatBalance'];
        });
      }
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

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
              cityname,
              style: TextStyle(fontSize: 16.sp, color: appColor),
            ),
            SizedBox(
              width: 5.w,
            ),
            InkWell(
              onTap: widget.address,
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
        InkWell(
          onTap: () {
            Get.to(() => const AddWaletBalnce());
          },
          child: Container(
              height: 32.h,
              width: 110.w,
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
                      '$waletBalance.00',
                      style: TextStyle(fontSize: 14.sp, color: appColor),
                    ),
                    Text(
                      'ريال',
                      style: TextStyle(fontSize: 13.sp, color: appColor),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
