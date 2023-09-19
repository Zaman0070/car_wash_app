import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/model/loaction_Model.dart';
import 'package:brush/services/share_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeDialoge extends StatefulWidget {
  int index;
  Function() close;
  Function() address;

  HomeDialoge(
      {super.key,
      required this.index,
      required this.close,
      required this.address});

  @override
  State<HomeDialoge> createState() => _HomeDialogeState();
}

class _HomeDialogeState extends State<HomeDialoge> {
  MySharedPreferences prefs = MySharedPreferences();
  LocationModel model = LocationModel();
  LocationModel? getlocationModel;
  getLocation() async {
    getlocationModel = await prefs.getModelData();
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  late int indexx = getlocationModel!.index!;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      width: 1.sw,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 30,
                ),
                Text(
                  'اختر موقعك الحالي',
                  style: TextStyle(fontSize: 15.sp, color: appColor),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImage.close,
                    height: 20.h,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 110.h,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('locations')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: appColor,
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          LocationModel locationModel = LocationModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return InkWell(
                            onTap: () {
                              setState(() {
                                indexx = index;
                                model = LocationModel(
                                    latitude: locationModel.latitude,
                                    longitude: locationModel.longitude,
                                    address: locationModel.address,
                                    addressType: locationModel.addressType,
                                    addressDetails:
                                        locationModel.addressDetails,
                                    uid: locationModel.uid,
                                    index: index);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Container(
                                height: 45.h,
                                width: 1.sw,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: appColor.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: 25.h,
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: appColor, width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: indexx == index
                                                      ? appColor
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          snapshot.data!.docs[index]['address'],
                                          textDirection: TextDirection.rtl,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 13.sp, color: appColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                    // return Wrap(
                    //     direction: Axis.horizontal,
                    //     children:
                    //         List.generate(snapshot.data!.docs.length, (index) {
                    //       LocationModel locationModel = LocationModel.fromMap(
                    //           snapshot.data!.docs[index].data());
                    //       return InkWell(
                    //         onTap: () {
                    //           setState(() {
                    //             indexx = index;
                    //             model = LocationModel(
                    //                 latitude: locationModel.latitude,
                    //                 longitude: locationModel.longitude,
                    //                 address: locationModel.address,
                    //                 addressType: locationModel.addressType,
                    //                 addressDetails:
                    //                     locationModel.addressDetails,
                    //                 uid: locationModel.uid,
                    //                 index: index);
                    //           });
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(vertical: 4),
                    //           child: Container(
                    //             height: 45.h,
                    //             width: 1.sw,
                    //             decoration: BoxDecoration(
                    //                 color: Theme.of(context)
                    //                     .scaffoldBackgroundColor,
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 boxShadow: [
                    //                   BoxShadow(
                    //                     color: appColor.withOpacity(0.2),
                    //                     spreadRadius: 0,
                    //                     blurRadius: 10,
                    //                     offset: const Offset(
                    //                         0, 3), // changes position of shadow
                    //                   ),
                    //                 ]),
                    //             child: Padding(
                    //               padding:
                    //                   const EdgeInsets.symmetric(horizontal: 5),
                    //               child: Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Container(
                    //                       width: 25.h,
                    //                       height: 25.h,
                    //                       decoration: BoxDecoration(
                    //                           border: Border.all(
                    //                               color: appColor, width: 1.5),
                    //                           borderRadius:
                    //                               BorderRadius.circular(50)),
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.all(2.0),
                    //                         child: Container(
                    //                           decoration: BoxDecoration(
                    //                               color: indexx == index
                    //                                   ? appColor
                    //                                   : Colors.transparent,
                    //                               borderRadius:
                    //                                   BorderRadius.circular(
                    //                                       30)),
                    //                         ),
                    //                       )),
                    //                   SizedBox(
                    //                     width: 200.w,
                    //                     child: Text(
                    //                       snapshot.data!.docs[index]['address'],
                    //                       textDirection: TextDirection.rtl,
                    //                       overflow: TextOverflow.fade,
                    //                       style: TextStyle(
                    //                           fontSize: 13.sp, color: appColor),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     }));
                  }),
            ),
            SizedBox(
              height: 15.h,
            ),
            AppButton(
                onTap: () async {
                  await prefs.saveModelData(model);
                  print(model);
                  Get.back();
                },
                text: 'اختر',
                barder: false),
            SizedBox(
              height: 10.h,
            ),
            AppButton(
                onTap: widget.address, text: 'اضافة موقع اخر', barder: true),
          ],
        ),
      ),
    );
  }
}
