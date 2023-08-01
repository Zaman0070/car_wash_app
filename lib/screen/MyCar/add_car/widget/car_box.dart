
import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarBox extends StatelessWidget {
  final String image;
  final String brand;
  final String painting;
  final String platNumber;
  final Function() edit;
  final Function() delete;
  const CarBox(
      {super.key,
      required this.image,
      required this.brand,
      required this.painting,
      required this.platNumber,
      required this.edit,
      required this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.network(
                    image,
                    height: 50.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand,
                        style: TextStyle(
                          color: appColor,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "رقم اللوحة:",
                            style: TextStyle(
                              color: appColor2,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "$platNumber $painting",
                            style: TextStyle(
                              color: appColor2,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: edit,
                        child: Icon(
                          Icons.edit,
                          size: 26.h,
                          color: appColor,
                        ),
                      ),
                      InkWell(
                        onTap: delete,
                        child: Icon(
                          Icons.delete,
                          size: 26.h,
                          color: appColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 25.h,
                    width: 25.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: appColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
