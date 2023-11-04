import 'package:brush/constant/app_image.dart';
import 'package:brush/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TimePickerHorizentialy extends StatefulWidget {
  final List<String> item;
  const TimePickerHorizentialy({super.key, required this.item});

  @override
  State<TimePickerHorizentialy> createState() => _TimePickerHorizentialyState();
}

class _TimePickerHorizentialyState extends State<TimePickerHorizentialy> {
  OrderController orderController = Get.put(OrderController());
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: appColor.withOpacity(0.1)),
        height: 50.h,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              reverse: true,
              itemCount: widget.item.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: InkWell(
                    onTap: () {
                      if (index == 1 ||
                          index == 2 ||
                          index == 6 ||
                          index == 8) {
                        Fluttertoast.showToast(msg: ' غير متاح الان');
                      } else {
                        setState(() {
                          _selectedItemIndex = index;
                          orderController.timeIdex.value = index;
                          orderController.update();
                        });
                      }
                    },
                    child: Container(
                        width: 33.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: _selectedItemIndex == index
                                ? appColor
                                : Colors.transparent),
                        child: Center(
                            child: Text(
                          widget.item[index],
                          style: TextStyle(
                              color: index == 1 ||
                                      index == 2 ||
                                      index == 6 ||
                                      index == 8
                                  ? Colors.red
                                  : _selectedItemIndex == index
                                      ? white
                                      : appColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ))),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
