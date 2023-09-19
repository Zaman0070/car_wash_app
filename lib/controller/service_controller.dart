import 'package:brush/model/services_Model.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController {
  RxList<ServicesModel> services = <ServicesModel>[].obs;
  RxList<int> selectedIndices = <int>[].obs;
  RxList<int> prices = <int>[0].obs;

  void toggleService(int index, ServicesModel service) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
      prices.remove(int.parse(service.servicePrice!));
      services.remove(service);
      update();
    } else {
      selectedIndices.add(index);
      prices.add(int.parse(service.servicePrice!));
      services.add(service);
      update();
    }
  }
}
