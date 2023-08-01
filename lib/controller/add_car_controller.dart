import 'package:brush/constant/widget/loading.dart';
import 'package:brush/model/addcar_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class AddCarController extends GetxController {
  var brandIndex = 0.obs;
  var modelIndex = 0.obs;
  var colorIndex = 0.obs;
  var myCar = <AddCarModels>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyCar();
  }

  void changeBrandIndex(int index) {
    brandIndex.value = index;
    update();
  }

  Future<void> fetchMyCar() async {
    try {
      SmartDialog.showLoading(
        animationBuilder: (controller, child, animationParam) {
          return Loading(
            text: ' ... تحميل ',
          );
        },
      );
      await FirebaseFirestore.instance
          .collection('AddCar')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('time')
          .get()
          .then((querySnapshot) {
        myCar.value = querySnapshot.docs
            .map((doc) => AddCarModels.fromMap(doc.data()))
            .toList();
      });
      update();
      SmartDialog.dismiss();
    } catch (e) {
      print(e);
    }
  }

  Future<void> editCarData(AddCarModels addCarModels, String id) async {
    try {
      SmartDialog.showLoading(
        animationBuilder: (controller, child, animationParam) {
          return Loading(
            text: ' ... تحميل ',
          );
        },
      );
      await FirebaseFirestore.instance
          .collection('AddCar')
          .doc(id)
          .update(addCarModels.toMap());
      update();
      Get.back();
      SmartDialog.dismiss();
    } catch (e) {
      print(e);
    }
  }
}
