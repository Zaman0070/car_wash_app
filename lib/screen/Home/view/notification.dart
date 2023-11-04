import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/Home/widget/notification_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'إشعارات',
          style: TextStyle(color: appColor),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Container(
                  width: 28.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), color: appColor),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: white,
                  )),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notifications')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return NotificationCard(
                  title: 'تم إضافة رصيد جديد',
                  body: 'تم إضافة رصيد جديد',
                  onPressed: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
