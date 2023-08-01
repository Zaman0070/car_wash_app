import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class Loading extends StatelessWidget {
  String text;
  Loading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160.h,
        width: 220.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.hexagonDots(
                size: 50,
                color: appColor,
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
