import 'package:brush/constant/app_image.dart';
import 'package:brush/controller/order_controller.dart';
import 'package:brush/screen/Home/view/add_new_address.dart';
import 'package:brush/screen/Home/view/new_order.dart';
import 'package:brush/screen/gifts/gifts.dart';
import 'package:brush/screen/offer/offer.dart';
import 'package:brush/screen/Home/widget/home_button.dart';
import 'package:brush/screen/Home/widget/home_dialoge.dart';
import 'package:brush/screen/Home/widget/home_wallet_box.dart';
import 'package:brush/screen/Home/widget/type_box.dart';
import 'package:brush/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OrderController orderController = Get.put(OrderController());
  String? currentAddress;
  String? latitude;
  String? longitude;
  Position? currentPosition;
  FirebaseServices firebaseServices = FirebaseServices();
  int index = 0;
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
        .then((Position position) {
      setState(() {
        currentPosition = position;
        latitude = currentPosition!.latitude.toString();
        longitude = currentPosition!.longitude.toString();
        currentAddress = '${position.latitude},${position.longitude}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: appColor,
                size: 32,
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text(
                      'اهلا بك',
                      style: TextStyle(color: appColor, fontSize: 17.sp),
                    );
                  }
                  return RichText(
                      text: TextSpan(
                          text: 'اهلا بك',
                          style: TextStyle(color: appColor, fontSize: 17.sp),
                          children: [
                        TextSpan(
                            text: ' ${snapshot.data!['name']}',
                            style: TextStyle(color: appColor, fontSize: 17.sp)),
                      ]));
                }),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HomeWalletBox(
                address: () {
                  address(
                      context: context,
                      address: () {
                        Future.delayed(const Duration(microseconds: 100), () {
                          Get.to(() => const AddNewAddress());
                        });
                      },
                      choose: () {
                        print('g');
                      },
                      index: index);
                },
                walletBalance: '0.0'),
            SizedBox(
              height: 18.h,
            ),
            HomeButton(
                onTap: () {
                  orderController.addCarModelsList.clear();
                  orderController.images.clear();
                  orderController.items.clear();
                  orderController.getCarData();
                  Get.to(() => const NewOrder());
                },
                text: 'حجز',
                barder: false),
            SizedBox(
              height: 12.h,
            ),
            Image.asset(AppImage.hslide),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'الأقسام',
              style: TextStyle(color: appColor, fontSize: 16.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            TypeBox(
              onTap: () {
                Get.to(() => const OfferPage());
              },
              image: 'assets/icons/Group 2270.png',
              text: 'الباقات',
            ),
            SizedBox(
              height: 10.h,
            ),
            TypeBox(
              onTap: () {
                Get.to(() => const Gifts());
              },
              image: 'assets/icons/Gifts.png',
              text: 'الهدايا',
            ),
          ]),
        ),
      ),
    );
  }

  address(
      {context,
      required Function() address,
      required Function() choose,
      required int index}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            1,
          ),
          child: HomeDialoge(
            index: index,
            close: choose,
            address: address,
          ),
        );
      },
    );
  }
}
