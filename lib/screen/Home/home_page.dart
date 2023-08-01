import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/Home/new_order.dart';
import 'package:brush/screen/gifts/gifts.dart';
import 'package:brush/screen/offer/offer.dart';
import 'package:brush/screen/Home/widget/home_button.dart';
import 'package:brush/screen/Home/widget/home_dialoge.dart';
import 'package:brush/screen/Home/widget/home_wallet_box.dart';
import 'package:brush/screen/Home/widget/type_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: appColor,
                size: 32,
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text(
                      'اهلا بك',
                      style: TextStyle(color: appColor, fontSize: 17.sp),
                    );
                  }
                  return RichText(
                      text: TextSpan(
                          text: 'اهلا بك',
                          style: TextStyle(color: appColor, fontSize: 17.sp),
                          children: [
                        TextSpan(
                            text: ' ${snapshot.data!['name']}',
                            style: TextStyle(color: appColor, fontSize: 17.sp)),
                      ]));
                }),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HomeWalletBox(
                address: () {
                  address(context, () {
                    // add another site
                  }, () {
                    //choose
                  }, index);
                },
                walletBalance: '0.0'),
            SizedBox(
              height: 18.h,
            ),
            HomeButton(
                onTap: () {
                  Get.to(() => const NewOrder());
                },
                text: 'حجز',
                barder: false),
            SizedBox(
              height: 12.h,
            ),
            Image.asset(AppImage.hslide),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'الأقسام',
              style: TextStyle(color: appColor, fontSize: 16.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            TypeBox(
              onTap: () {
                Get.to(() => const OfferPage());
              },
              image: 'assets/icons/Group 2270.png',
              text: 'الباقات',
            ),
            SizedBox(
              height: 10.h,
            ),
            TypeBox(
              onTap: () {
                Get.to(() => const Gifts());
              },
              image: 'assets/icons/Gifts.png',
              text: 'الهدايا',
            ),
          ]),
        ),
      ),
    );
  }

  address(context, Function() address, Function() choose, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            1,
          ),
          child: HomeDialoge(
            index: index,
            close: choose,
            address: address,
          ),
        );
      },
    );
  }
}
