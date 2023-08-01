import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool obSecure = false;
  final String? Function(String?)? validator;
  final String? Function(String?)? change;
  TextInputType keyboardType;
  final Color color;
  String lable;
  InputTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.lable,
      required this.obSecure,
      this.change,
      required this.color,
      this.validator,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: TextStyle(color: appColor),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
                border: Border.all(color: appColor)),
            height: 43.h,
            child: TextFormField(
              onChanged: change,
              validator: validator,
              textDirection: TextDirection.rtl,
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              obscureText: obSecure,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle:
                      TextStyle(fontSize: 16.sp, color: Colors.grey.shade400)),
            ),
          ),
        ],
      ),
    );
  }
}
