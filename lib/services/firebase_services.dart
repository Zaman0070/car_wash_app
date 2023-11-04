import 'dart:math';

import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/loading.dart';
import 'package:brush/model/addcar_Model.dart';
import 'package:brush/model/loaction_Model.dart';
import 'package:brush/model/order_Model.dart';
import 'package:brush/model/services_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FirebaseServices {
  final CollectionReference addCar =
      FirebaseFirestore.instance.collection("AddCar");
  final CollectionReference orders =
      FirebaseFirestore.instance.collection("orders");
  final CollectionReference location =
      FirebaseFirestore.instance.collection("locations");

  Future<void> addCarToFirebase({
    required String brand,
    required String model,
    required String color,
    required String plateNumber,
    required String image,
    required String painting,
    required int brandIndex,
    required int modelIndex,
    required int colorIndex,
  }) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(text: '....جاري اضافة السيارة');
      },
    );
    try {
      AddCarModels addCarModels = AddCarModels(
          brand: brand,
          model: model,
          color: color,
          plateNumber: plateNumber,
          image: image,
          painting: painting,
          brandIndex: brandIndex,
          modelIndex: modelIndex,
          colorIndex: colorIndex,
          uid: FirebaseAuth.instance.currentUser!.uid,
          time: DateTime.now().millisecondsSinceEpoch);
      await addCar.doc().set(addCarModels.toMap()).then((value) {
        Get.back();
        Get.snackbar('بنجاح!', 'تم اضافة السيارة بنجاح',
            backgroundColor: white);
        SmartDialog.dismiss();
      });
    } catch (e) {
      SmartDialog.dismiss();
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: 'Something went wrong !',
          backgroundColor: appColor);
    }
  }

  // new order
  Future<void> newOrder({
    required final List<ServicesModel> services,
    required final String time,
    required final String date,
    required final String price,
    required final String latitude,
    required final String longitude,
    required final String address,
    required String brand,
    required String model,
    required String color,
    required String plateNumber,
    required String painting,
    required String image,
  }) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(text: '....جاري اضافة السيارة');
      },
    );
    int orderNumber = Random().nextInt(100000);
    try {
      OrderModel orderModel = OrderModel(
          services: services,
          orderNumber: orderNumber,
          time: time,
          date: date,
          price: price,
          latitude: latitude,
          longitude: longitude,
          address: address,
          brand: brand,
          model: model,
          color: color,
          plateNumber: plateNumber,
          painting: painting,
          image: image,
          uid: FirebaseAuth.instance.currentUser!.uid,
          orderTime: DateTime.now().millisecondsSinceEpoch);
      await orders.doc().set(orderModel.toMap()).then((value) {
        Get.back();
        Get.snackbar('بنجاح!', 'تم اضافة السيارة بنجاح',
            backgroundColor: white);
        SmartDialog.dismiss();
      });
    } catch (e) {
      SmartDialog.dismiss();
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: 'Something went wrong !',
          backgroundColor: appColor);
    }
  }

  Future<void> addLoaction({
    required final String latitude,
    required final String longitude,
    required final String address,
    required final String addressType,
    required final String addressDetails,
    required final String cityName,
  }) async {
    try {
      LocationModel locationModel = LocationModel(
          latitude: latitude,
          longitude: longitude,
          address: address,
          addressType: addressType,
          addressDetails: addressDetails,
          uid: FirebaseAuth.instance.currentUser!.uid,
          cityName: cityName,
          index: 0);
      await location.doc().set(locationModel.toMap());
    } catch (e) {
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: 'Something went wrong !',
          backgroundColor: appColor);
      print(e);
      throw e;
    }
  }
}
