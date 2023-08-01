import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/gifts/received_gift.dart';
import 'package:brush/screen/gifts/sent_gift.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Gifts extends StatelessWidget {
  const Gifts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'الهدايا',
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
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Directionality(
                textDirection: TextDirection.rtl,
                child: ButtonsTabBar(
                  height: 45.h,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                  ),
                  radius: 6,
                  backgroundColor: appColor,
                  borderColor: appColor,
                  borderWidth: 1,
                  unselectedBorderColor: appColor,
                  unselectedBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  unselectedLabelStyle: TextStyle(color: appColor),
                  labelStyle: TextStyle(
                    color: white,
                  ),
                  tabs: const [
                    Tab(
                      text: "الهداية المستلمة",
                    ),
                    Tab(
                      text: "الهداية المرسلة ",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ReceivedGift(),
                    SentGift(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
