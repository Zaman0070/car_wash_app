// ignore: file_names
import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/MyOrder/widget/current_order.dart';
import 'package:brush/screen/MyOrder/widget/privious_order.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'طلباتي',
          style: TextStyle(color: appColor),
        ),
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
                      text: "الطلبات الحالية",
                    ),
                    Tab(
                      text: "الطلبات السابقة",
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[CurrentOrder(), PreviousOrder()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
