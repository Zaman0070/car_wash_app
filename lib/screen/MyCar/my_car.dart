import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/loading.dart';
import 'package:brush/model/addcar_Model.dart';
import 'package:brush/screen/MyCar/add_car/add_car.dart';
import 'package:brush/screen/MyCar/add_car/widget/car_box.dart';
import 'package:brush/screen/MyCar/add_car/widget/edit.dart';
import 'package:brush/screen/MyOrder/widget/current_add_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class MyCars extends StatelessWidget {
  const MyCars({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('AddCar')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .orderBy('time')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container();
              }
              if (snapshot.data!.docs.isNotEmpty) {
                return InkWell(
                  onTap: () {
                    Get.to(() => const AddCar());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      AppImage.add,
                    ),
                  ),
                );
              }
              return Container();
            }),
        title: Text(
          'سياراتي',
          style: TextStyle(color: appColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('AddCar')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .orderBy('time')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: appColor,
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CurrentAddBox(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        title: 'لا يوجد سيارات',
                        image: AppImage.car,
                        buttonTitle: 'اضف سيارة',
                        onTap: () {
                          Get.to(() => const AddCar());
                        }),
                  ]);
            }
            return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  AddCarModels addCarModels =
                      AddCarModels.fromMap(snapshot.data!.docs[index].data());
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CarBox(
                      delete: () async {
                        SmartDialog.showLoading(
                          animationBuilder:
                              (controller, child, animationParam) {
                            return Loading(
                              text: ' ... تحميل ',
                            );
                          },
                        );
                        Future.delayed(const Duration(seconds: 2))
                            .whenComplete(() async {
                          await FirebaseFirestore.instance
                              .collection('AddCar')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                          SmartDialog.dismiss();
                        });
                      },
                      edit: () {
                        Get.to(
                          () => EditCar(
                            id: snapshot.data!.docs[index].id,
                            addCarModels: addCarModels,
                          ),
                        );
                      },
                      image: addCarModels.image!,
                      brand: addCarModels.brand!,
                      painting: addCarModels.painting!,
                      platNumber: addCarModels.plateNumber!,
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
