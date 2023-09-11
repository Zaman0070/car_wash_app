import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ChooseCar extends StatelessWidget {
  final String brand;
  final String title;
  final String image;
  final bool isBrand;

  final Function() onTap;
  const ChooseCar({
    super.key,
    required this.brand,
    required this.image,
    required this.title,
    required this.onTap,
    required this.isBrand,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(color: appColor)),
              height: 43.h,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    Row(
                      children: [
                        isBrand
                            ? Image.network(
                                image,
                                height: 20.h,
                              )
                            : Container(),
                        const SizedBox(width: 10),
                        Text(brand, style: TextStyle(color: appColor)),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: onTap,
                          child: CircleAvatar(
                            radius: 12.h,
                            backgroundColor: appColor,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Icon(Icons.arrow_back_ios,
                                    size: 18.h, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
