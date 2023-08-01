import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/Home/home_page.dart';
import 'package:brush/screen/More/more.dart';
import 'package:brush/screen/MyCar/my_car.dart';
import 'package:brush/screen/MyOrder/my_Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationBars extends StatefulWidget {
  const BottomNavigationBars({super.key});

  @override
  State<BottomNavigationBars> createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {
  Widget currentScreen =  HomePage();
  int index = 0;

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: const Color(0xff675492),
            child: PageStorage(
              bucket: _bucket,
              child: currentScreen,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).canvasColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 70.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appColor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      color: Colors.grey.shade400,
                      blurRadius: 5)
                ]),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 3;
                          currentScreen = const More();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            AppImage.more,
                            height: 6.h,
                            color: index == 3 ? white : white.withOpacity(0.6),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'المزيد',
                            style: TextStyle(
                                color:
                                    index == 3 ? white : white.withOpacity(0.6),
                                fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 2;
                          currentScreen = const MyCars();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImage.car,
                            height: 22.h,
                            color: index == 2 ? white : white.withOpacity(0.6),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'سياراتي',
                            style: TextStyle(
                                color:
                                    index == 2 ? white : white.withOpacity(0.6),
                                fontSize: 13.sp),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 1;
                          currentScreen = const MyOrder();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImage.calender,
                            height: 22.h,
                            color: index == 1 ? white : white.withOpacity(0.6),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'طلباتي',
                            style: TextStyle(
                                color:
                                    index == 1 ? white : white.withOpacity(0.6),
                                fontSize: 13.sp),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 0;
                          currentScreen =  HomePage();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImage.home,
                            height: 22.h,
                            color: index == 0 ? white : white.withOpacity(0.6),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'الرئيسية',
                            style: TextStyle(
                                color:
                                    index == 0 ? white : white.withOpacity(0.6),
                                fontSize: 13.sp),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
