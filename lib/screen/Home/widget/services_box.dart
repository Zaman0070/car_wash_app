import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ServiceBox extends StatefulWidget {
  final String title;
  final int price;
  bool isSelected;
  ServiceBox(
      {super.key,
      required this.title,
      required this.price,
      required this.isSelected});

  @override
  State<ServiceBox> createState() => _ServiceBoxState();
}

class _ServiceBoxState extends State<ServiceBox> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 55.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/icons/offer.png'),
                SizedBox(
                  width: 6.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 16.sp, color: black),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      '${widget.price} ريال',
                      style: TextStyle(
                          fontSize: 14.5.sp, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.isSelected = !widget.isSelected;
                });
              },
              child: Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: appColor),
                  ),
                  child: Icon(
                    Icons.check,
                    color: widget.isSelected ? appColor : Colors.transparent,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
