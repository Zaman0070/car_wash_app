import 'package:brush/constant/app_image.dart';
import 'package:brush/controller/add_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CarColor extends StatelessWidget {
  final List<Color> color;
  final List<String> images;
  final List<String> name;
  final Function() onTap;

  CarColor(
      {super.key,
      required this.color,
      required this.images,
      required this.name,
      required this.onTap});
  AddCarController addCarController = Get.put(AddCarController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 1.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: appColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: color.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                addCarController.colorIndex.value = index;
                addCarController.update();
                print(addCarController.colorIndex.value);
              },
              child: Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      images[index],
                      height: 35.h,
                      color: index == 1 ? null : color[index],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      name[index],
                      style: TextStyle(
                        color: index == 1 ? appColor : color[index],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
