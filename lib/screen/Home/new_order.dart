import 'package:brush/constant/app_image.dart';
import 'package:brush/controller/order_controller.dart';
import 'package:brush/screen/Home/widget/homebutton.dart';
import 'package:brush/screen/Home/widget/services_box.dart';
import 'package:brush/screen/Home/widget/timePicker.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final bool service1 = false;

  final bool service2 = false;

  final bool service3 = false;
  DateTime? selectedDate;
  DatePickerController _controller = DatePickerController();
  OrderController orderController = Get.put(OrderController());
  List<String> item = [
    '12',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'طلب جديد',
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ServiceBox(
                  title: 'فواحة عطرية',
                  price: 3,
                  isSelected: service1,
                ),
                SizedBox(height: 8.h),
                ServiceBox(
                  title: 'مناديل',
                  price: 3,
                  isSelected: service2,
                ),
                SizedBox(height: 8.h),
                ServiceBox(
                  title: 'مناديل تنظيف مبللة',
                  price: 3,
                  isSelected: service3,
                ),
                SizedBox(height: 10.h),
                Text('الوقت والتاريخ',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.h,
                    )),
                SizedBox(height: 7.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('اقرب وقت متاح',
                        style: TextStyle(
                          color: black,
                          fontSize: 14.h,
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appColor),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Text(
                              'اليوم',
                              style: TextStyle(color: white, fontSize: 16.sp),
                            ),
                            Obx(() {
                              return Text(
                                ' ${item[orderController.timeIdex.value]}:00  ',
                                style: TextStyle(color: white, fontSize: 16.sp),
                              );
                            }),
                            Text(
                              'م',
                              style: TextStyle(color: white, fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text('او قم باختيار تاريخ محدد',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.h,
                    )),
                SizedBox(height: 4.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: appColor.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('مارس',
                                    style: TextStyle(
                                      color: appColor,
                                      fontSize: 20.h,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(width: 2.w),
                                Text(i.DateFormat.y().format(DateTime.now()),
                                    style: TextStyle(
                                      color: appColor,
                                      fontSize: 20.h,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.animateToDate(DateTime.now()
                                        .add(const Duration(days: 1)));
                                  });
                                },
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: appColor))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DatePicker(
                          DateTime.now(),
                          controller: _controller,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: appColor,
                          selectedTextColor: Colors.white,
                          monthTextStyle:
                              const TextStyle(color: Colors.transparent),
                          dateTextStyle: TextStyle(
                              color: appColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          dayTextStyle: TextStyle(color: appColor),
                          locale: 'ar',
                          height: 85.h,
                          deactivatedColor: appColor,
                          onDateChange: (date) {
                            setState(() {
                              selectedDate = date;
                              print(selectedDate);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text('أوقات الدوام من ال12 مساء حتي ال8 مساء',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.h,
                    )),
                SizedBox(height: 4.h),
                TimePickerHorizentialy(item: item),
                SizedBox(height: 20.h),
                Obx(() {
                  return HomeButton2(
                    ontap: () {},
                    date: i.DateFormat('MMM d').format(DateTime.now()),
                    time: item[orderController.timeIdex.value],
                    price: 2,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
