import 'dart:developer';

import 'package:brush/constant/app_image.dart';
import 'package:brush/controller/order_controller.dart';
import 'package:brush/model/addcar_Model.dart';
import 'package:brush/model/loaction_Model.dart';
import 'package:brush/model/services_Model.dart';
import 'package:brush/screen/Home/widget/choose_car_bottom.dart';
import 'package:brush/screen/Home/widget/choose_car_model.dart';
import 'package:brush/screen/Home/widget/homebutton.dart';
import 'package:brush/screen/Home/widget/services_box.dart';
import 'package:brush/screen/Home/widget/timePicker.dart';
import 'package:brush/services/firebase_services.dart';
import 'package:brush/services/share_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  DateTime? selectedDate;
  final DatePickerController _controller = DatePickerController();
  OrderController orderController = Get.put(OrderController());
  List<String> item = [
    '12',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
  ];
  FirebaseServices firebaseServices = FirebaseServices();
  Set<int> selectedIndices = {};
  Set<int> price = {0};
  final int _selectedItemIndex = 0;

  List<ServicesModel> services = [];

  // current Loaction
  String? currentAddress;
  String? latitude;
  String? longitude;
  Position? currentPosition;
  @override
  void initState() {
    getCarData();
    getLocation();
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      await placemarkFromCoordinates(position.latitude, position.longitude,
              localeIdentifier: 'ar_AR')
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        setState(() {
          currentAddress =
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.locality} , ${place.country}';
          log(currentAddress.toString());
        });
      });

      setState(() {
        currentPosition = position;
        latitude = currentPosition!.latitude.toString();
        longitude = currentPosition!.longitude.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  List<dynamic> images = [];
  List<dynamic> items = [];

  List<AddCarModels> addCarModelsList = [];
  MySharedPreferences prefs = MySharedPreferences();
  LocationModel? getlocationModel;
  getLocation() async {
    getlocationModel = await prefs.getModelData();
  }

  getCarData() async {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection('AddCar').snapshots();
    stream.forEach((element) {
      for (var element in element.docs) {
        if (!element.exists) {
          return;
        }
        AddCarModels addCarModels = AddCarModels.fromMap(element.data());
        setState(() {
          images.add(addCarModels.image);
          items.add(addCarModels.brand);
          addCarModelsList.add(addCarModels);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'طلب جديد',
          style: TextStyle(color: appColor),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Container(
                  width: 28.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), color: appColor),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: white,
                  )),
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('services')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('لا يوجد خدمات'));
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ServicesModel servicesModel = ServicesModel.fromMap(
                                snapshot.data!.docs[index].data());
                            bool isSelected = selectedIndices.contains(index);
                            return ServiceBox(
                                index: index,
                                serviceName: servicesModel.serviceName!,
                                servicePrice: servicesModel.servicePrice!,
                                serviceImage: servicesModel.serviceImage!,
                                selectedIndices: selectedIndices,
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedIndices.remove(index);
                                      price.remove(servicesModel.servicePrice!);
                                      services.remove(servicesModel);
                                    } else {
                                      selectedIndices.add(index);
                                      price.add(int.parse(
                                          servicesModel.servicePrice!));
                                      services.add(servicesModel);
                                      getCurrentPosition();
                                    }
                                  });
                                });
                          });
                    }),
                SizedBox(height: 12.h),
                //
                Obx(() {
                  return ChooseCarModel(
                    brand: () {
                      Get.bottomSheet(ChooseCarBottomSheets(
                        isBrand: true,
                        image: images,
                        selectedItemIndex: _selectedItemIndex,
                        item: orderController.items,
                        addCarModels: orderController
                            .addCarModelsList[orderController.carIndex.value],
                      ));
                    },
                    brandName:
                        orderController.items[orderController.carIndex.value],
                    image:
                        orderController.images[orderController.carIndex.value],
                    addCarModels: orderController
                        .addCarModelsList[orderController.carIndex.value],
                  );
                }),
                SizedBox(height: 12.h),
                Text('الوقت والتاريخ',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.h,
                    )),
                SizedBox(height: 7.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('اقرب وقت متاح',
                        style: TextStyle(
                          color: black,
                          fontSize: 14.h,
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appColor),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Text(
                              'اليوم',
                              style: TextStyle(color: white, fontSize: 16.sp),
                            ),
                            Obx(() {
                              return Text(
                                ' ${item[orderController.timeIdex.value]}:00  ',
                                style: TextStyle(color: white, fontSize: 16.sp),
                              );
                            }),
                            Text(
                              'م',
                              style: TextStyle(color: white, fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text('او قم باختيار تاريخ محدد',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.h,
                    )),
                SizedBox(height: 4.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: appColor.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('مارس',
                                    style: TextStyle(
                                      color: appColor,
                                      fontSize: 20.h,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(width: 2.w),
                                Text(i.DateFormat.y().format(DateTime.now()),
                                    style: TextStyle(
                                      color: appColor,
                                      fontSize: 20.h,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.animateToDate(DateTime.now()
                                        .add(const Duration(days: 1)));
                                  });
                                },
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: appColor))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DatePicker(
                          DateTime.now(),
                          controller: _controller,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: appColor,
                          selectedTextColor: Colors.white,
                          monthTextStyle:
                              const TextStyle(color: Colors.transparent),
                          dateTextStyle: TextStyle(
                              color: appColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          dayTextStyle: TextStyle(color: appColor),
                          locale: 'ar',
                          height: 85.h,
                          deactivatedColor: appColor,
                          onDateChange: (date) {
                            setState(() {
                              selectedDate = date;
                              print(selectedDate.toString()
                                ..replaceAll('00', '').replaceAll('0:', ''));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text('أوقات الدوام من ال12 مساء حتي ال8 مساء',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.h,
                    )),
                SizedBox(height: 4.h),
                TimePickerHorizentialy(item: item),
                SizedBox(height: 20.h),
                Obx(() {
                  return HomeButton2(
                    ontap: () async {
                      if (services.isNotEmpty &&
                          orderController.addCarModel.value.brand != null) {
                        await firebaseServices.newOrder(
                          services: services,
                          time: ' ${item[orderController.timeIdex.value]}:00',
                          date: selectedDate
                              .toString()
                              .replaceAll('00:00:00.000', ''),
                          price: price
                              .reduce((value, element) => value + element)
                              .toString(),
                          latitude: currentPosition!.latitude.toString(),
                          longitude: currentPosition!.longitude.toString(),
                          address: getlocationModel != null
                              ? getlocationModel!.address!
                              : currentAddress!,
                          brand: orderController.addCarModel.value.brand!,
                          color: orderController.addCarModel.value.color!,
                          image: orderController.addCarModel.value.image!,
                          model: orderController.addCarModel.value.model!,
                          painting: orderController.addCarModel.value.painting!,
                          plateNumber:
                              orderController.addCarModel.value.plateNumber!,
                        );
                      } else {
                        Get.snackbar(
                            'خطأ', 'من فضلك اختر الخدمات والوقت والتاريخ',
                            backgroundColor: Colors.red);
                      }
                    },
                    date: i.DateFormat('MMM d').format(DateTime.now()),
                    time: item[orderController.timeIdex.value],
                    price: price.reduce((value, element) => value + element),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
