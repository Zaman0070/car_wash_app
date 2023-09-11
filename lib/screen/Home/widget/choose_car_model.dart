import 'package:brush/constant/app_image.dart';
import 'package:brush/model/addcar_Model.dart';
import 'package:brush/screen/Home/widget/choos_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseCarModel extends StatelessWidget {
  final Function() brand;
  final String image;
  final String brandName;
  final AddCarModels? addCarModels;
  const ChooseCarModel(
      {super.key,
      required this.brand,
      required this.image,
      required this.brandName,
      this.addCarModels});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
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
      child: Column(
        children: [
          ChooseCar(
            isBrand: true,
            image: image,
            onTap: brand,
            title: 'حدد السيارة',
            brand: brandName,
          ),
        ],
      ),
    );
  }
}
