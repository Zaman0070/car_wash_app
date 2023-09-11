import 'package:brush/constant/app_image.dart';
import 'package:brush/model/order_Model.dart';
import 'package:brush/screen/MyOrder/my_order_details.dart';
import 'package:brush/screen/MyOrder/widget/sub_widget/priviour_order_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PreviousOrder extends StatelessWidget {
  const PreviousOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  OrderModel orderModel =
                      OrderModel.fromMap(snapshot.data!.docs[index].data());
                  return PiviousOrderBox(
                    onTap: () {
                      Get.to(() => MyOrderDetails(
                            orderModel: orderModel,
                          ));
                    },
                    modelname: orderModel.brand!,
                    plateNumber: orderModel.plateNumber!,
                    image: orderModel.image!,
                    date:
                        'التاريخ و الوقت ${orderModel.time!}  ${orderModel.date!}',
                    orderNumber: 'رقم الطلب${orderModel.orderNumber}#',
                  );
                },
              );
            }
            return Column(
              children: [
                Container(
                  height: 200.h,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appColor.withOpacity(0.05),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset('assets/icons/Group 2231.png'),
                  ),
                ),
              ],
            );
          }),
    ));
  }
}
