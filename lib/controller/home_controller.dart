import 'package:brush/constant/widget/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  // set date
  void setDate(DateTime date) {
    selectedDate.value = date;
    update();
  }

  // add balance
  void addBalance(int balance) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: ' ... تحميل ',
        );
      },
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'walatBalance': balance});
    SmartDialog.dismiss();
    Get.back();
  }
}
