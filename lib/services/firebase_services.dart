import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/loading.dart';
import 'package:brush/model/addcar_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FirebaseServices {
  final CollectionReference addCar =
      FirebaseFirestore.instance.collection("AddCar");

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
}
