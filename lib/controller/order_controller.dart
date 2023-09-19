import 'package:brush/model/addcar_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var carIndex = 0.obs;
  var timeIdex = 0.obs;
  var addCarModel = AddCarModels().obs;
  var addCarModelsList = <AddCarModels>[].obs;
  var images = <dynamic>[].obs;
  var items = <dynamic>[].obs;

  RxInt selectedItemIndex = 0.obs;
  RxBool isBrand = true.obs;

  @override
  void onInit() {
    getCarData();
    super.onInit();
  }

  getCarData() async {
    // addCarModelsList.clear();
    // images.clear();
    // items.clear();
    await FirebaseFirestore.instance
        .collection('AddCar')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (addCarModelsList.isNotEmpty) {
        addCarModelsList.clear();
        images.clear();
        items.clear();
      }
      for (var element in value.docs) {
        addCarModelsList.add(AddCarModels.fromMap(element.data()));
        images.add(element.data()['image']);
        items.add(element.data()['brand']);
      }
      update();
    });
  }
}
