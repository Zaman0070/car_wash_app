import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeDialoge extends StatefulWidget {
  int index;
  Function() close;
  Function() address;

  HomeDialoge(
      {super.key,
      required this.index,
      required this.close,
      required this.address});

  @override
  State<HomeDialoge> createState() => _HomeDialogeState();
}

class _HomeDialogeState extends State<HomeDialoge> {
  int indexx = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      width: 1.sw,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 30,
                ),
                Text(
                  'اختر موقعك الحالي',
                  style: TextStyle(fontSize: 15.sp, color: appColor),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImage.close,
                    height: 20.h,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 45.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: appColor.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.index = 0;
                        });
                      },
                      child: Container(
                          width: 30.h,
                          height: 30.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: appColor, width: 1.5),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: widget.index == 0
                                      ? appColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        Text(
                          '(البيت)',
                          style: TextStyle(fontSize: 15.sp, color: appColor),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'الرياض حي الشفا',
                          style: TextStyle(fontSize: 15.sp, color: appColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 45.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: appColor.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.index = 1;
                        });
                      },
                      child: Container(
                          width: 30.h,
                          height: 30.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: appColor, width: 1.5),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: widget.index == 1
                                      ? appColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        Text(
                          '(العمل)',
                          style: TextStyle(fontSize: 15.sp, color: appColor),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'الرياض حي الأزهر',
                          style: TextStyle(fontSize: 15.sp, color: appColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            AppButton(onTap: widget.close, text: 'اختر', barder: false),
            SizedBox(
              height: 10.h,
            ),
            AppButton(
                onTap: widget.address, text: 'اضافة موقع اخر', barder: true),
          ],
        ),
      ),
    );
  }
}
