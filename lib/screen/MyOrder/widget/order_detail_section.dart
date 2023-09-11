import 'package:brush/constant/app_image.dart';
import 'package:brush/model/order_Model.dart';
import 'package:brush/model/services_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailSection extends StatelessWidget {
  final OrderModel orderModel;
  const OrderDetailSection({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'رقم الطلب',
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    'التاريخ و الوقت',
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '#${orderModel.orderNumber}',
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    '${orderModel.time!}  ${orderModel.date!}'
                        .replaceAll('-', '/'),
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: appColor.withOpacity(0.1),
            thickness: 1,
          ),
          ListView.builder(
              itemCount: orderModel.services!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ServicesModel servicesModel = orderModel.services![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        servicesModel.serviceName!,
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 14.sp),
                      ),
                      Text(
                        '${servicesModel.servicePrice!} ريال',
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                    ],
                  ),
                );
              }),
          Divider(
            color: appColor.withOpacity(0.1),
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الأجمالي (شامل الضريبة)',
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${orderModel.price} ريال',
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
