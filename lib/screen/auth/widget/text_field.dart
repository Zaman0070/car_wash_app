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

// ignore: must_be_immutable
class PhoneInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool obSecure = false;
  final String? Function(String?)? validator;
  final String? Function(String?)? change;
  TextInputType keyboardType;
  final Color color;
  String lable;
  final String code;
  PhoneInputTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.lable,
      required this.obSecure,
      this.change,
      required this.color,
      this.validator,
      required this.keyboardType,
      required this.code});

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
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'من فضلك ادخل رقم الهاتف';
                }
                return null;
              },
              maxLength: 9,
              onChanged: change,
              keyboardType: TextInputType.phone,
              controller: controller,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: appColor.withOpacity(0.06),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    10.r,
                  ),
                  borderSide: BorderSide(color: appColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    10.r,
                  ),
                  borderSide: BorderSide(
                    color: appColor,
                    width: 1.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                hintText: '1234 56789',
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade400,
                ),
                hintTextDirection: TextDirection.ltr,
                contentPadding: const EdgeInsets.only(top: 0, right: 15),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: appColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6.6),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          code,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class AddressInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool obSecure = false;
  final String? Function(String?)? validator;
  final String? Function(String?)? change;
  TextInputType keyboardType;
  final Color color;
  AddressInputTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obSecure,
    this.change,
    required this.color,
    this.validator,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'من فضلك ادخل رقم الهاتف';
            }
            return null;
          },
          onChanged: change,
          keyboardType: keyboardType,
          controller: controller,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            filled: true,
            fillColor: appColor.withOpacity(0.06),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
              borderSide: BorderSide(color: appColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
              borderSide: BorderSide(
                color: appColor,
                width: 1.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade400,
            ),
            hintTextDirection: TextDirection.ltr,
            contentPadding: const EdgeInsets.only(top: 0, right: 15),
          ),
        ),
      ),
    );
  }
}
