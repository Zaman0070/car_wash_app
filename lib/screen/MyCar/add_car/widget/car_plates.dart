import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/auth/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarPlates extends StatelessWidget {
  final TextEditingController plateNumber;
  final TextEditingController painting;
  CarPlates({super.key, required this.plateNumber, required this.painting});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165.h,
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
            InputTextField(
              keyboardType: TextInputType.number,
              color: Colors.transparent,
              lable: 'رقم اللوحة',
              controller: plateNumber,
              hintText: 'رقم اللوحة',
              obSecure: false,
            ),
            SizedBox(
              height: 6.h,
            ),
            InputTextField(
              keyboardType: TextInputType.name,
              color: Colors.transparent,
              lable: 'احرف اللوحة',
              controller: painting,
              hintText: 'احرف اللوحة',
              obSecure: false,
            ),
          ],
        ),
      ),
    );
  }
}
