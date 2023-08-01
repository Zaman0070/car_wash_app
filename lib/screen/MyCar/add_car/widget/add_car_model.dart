import 'package:brush/constant/app_image.dart';
import 'package:brush/model/addcar_Model.dart';
import 'package:brush/screen/MyCar/add_car/widget/car_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCarModel extends StatelessWidget {
  final Function() brand;
  final Function() model;
  final String image;
  final String modelNmae;
  final String brandName;
  final AddCarModels? addCarModels;
  const AddCarModel(
      {super.key,
      required this.brand,
      required this.model,
      required this.image,
      required this.modelNmae,
      required this.brandName,
       this.addCarModels
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CarInputTextField(
              isBrand: true,
              image: image,
              onTap: brand,
              title: 'الماركة',
              brand: brandName,
            ),
            SizedBox(height: 10.h),
            CarInputTextField(
              isBrand: false,
              image: AppImage.add,
              onTap: model,
              title: 'الموديل',
              brand: modelNmae,
            ),
          ],
        ),
      ),
    );
  }
}
