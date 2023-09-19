import 'dart:developer';

import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/controller/order_controller.dart';
import 'package:brush/model/addcar_Model.dart';
import 'package:brush/screen/Home/widget/choos_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChooseCarBottomSheets extends StatefulWidget {
  List<dynamic> image;
  List<dynamic> item;
  int selectedItemIndex;
  bool isBrand;
  AddCarModels addCarModels;
  ChooseCarBottomSheets({
    super.key,
    required this.item,
    required this.selectedItemIndex,
    required this.image,
    required this.isBrand,
    required this.addCarModels,
  });

  @override
  State<ChooseCarBottomSheets> createState() => _ChooseCarBottomSheetsState();
}

class _ChooseCarBottomSheetsState extends State<ChooseCarBottomSheets> {
  OrderController addCarController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 28.w,
                ),
                Text(
                  'نوع المركبة',
                  style: TextStyle(fontSize: 15.sp),
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
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    ChooseCar(
                        isBrand: true,
                        image: widget.image[widget.selectedItemIndex],
                        brand: widget.item[widget.selectedItemIndex],
                        title: 'نوع المركبة',
                        onTap: () {}),
                    Container(
                      height: 185.h,
                      width: 220.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          border: Border.all(color: appColor)),
                      child: ListWheelScrollView(
                        controller: FixedExtentScrollController(
                            initialItem: widget.selectedItemIndex),
                        itemExtent: 40,
                        diameterRatio: 5.0,
                        onSelectedItemChanged: (int index) {
                          // update the UI on selected item changes
                          setState(() {
                            widget.selectedItemIndex = index;
                            addCarController.carIndex.value = index;
                            addCarController.addCarModel.value =
                                widget.addCarModels.copyWith(
                                    brand: widget.item[index],
                                    brandIndex: index,
                                    image: widget.image[index]);
                            addCarController.update();

                            widget.addCarModels = widget.addCarModels.copyWith(
                                brand: widget.item[index],
                                brandIndex: index,
                                image: widget.image[index]);
                          });
                        },
                        children: widget.item
                            .map((e) => SizedBox(
                                  height: 10.h,
                                  width: 200.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        widget.image[widget.item.indexOf(e)],
                                        height: 15.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        e,
                                        style: TextStyle(
                                            color: widget.item.indexOf(e) ==
                                                    widget.selectedItemIndex
                                                ? appColor
                                                : Colors.grey.shade400,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    AppButton(
                        onTap: () {
                          log(widget.addCarModels.toString());
                          log(addCarController.carIndex.value.toString());
                          Get.back();
                        },
                        text: 'تم',
                        barder: false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
