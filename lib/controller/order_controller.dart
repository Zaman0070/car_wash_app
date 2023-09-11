import 'package:brush/model/addcar_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var carIndex = 0.obs;
  var timeIdex = 0.obs;
  var addCarModel = AddCarModels().obs;
  var addCarModelsList = <AddCarModels>[].obs;
  var images = <dynamic>[].obs;
  var items = <dynamic>[].obs;

  @override
  void onInit() {
    getCarData();
    super.onInit();
  }

  getCarData() async {
    FirebaseFirestore.instance.collection('AddCar').get().then((value) {
      for (var element in value.docs) {
        AddCarModels addCarModels = AddCarModels.fromMap(element.data());
        images.add(addCarModels.image);
        items.add(addCarModels.brand);
        addCarModelsList.add(addCarModels);
        update();
      }
    });
  }
}
