import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/constant/widget/loading.dart';
import 'package:brush/screen/Home/widget/address_type.dart';
import 'package:brush/screen/auth/widget/text_field.dart';
import 'package:brush/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  GoogleMapController? _controller;
  int index = 0;
  List<String> addressType = ['المنزل', 'العمل', 'مكان اخر'];
  TextEditingController controller = TextEditingController();
  FirebaseServices firebaseServices = FirebaseServices();

  // static const LatLng _center = const LatLng(45.521563, -122.677433);
  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 435.h,
                child: Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      onMapCreated: (controller) {
                        _controller = controller;
                        _getCurrentLocation();
                      },
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(0, 0),
                        zoom: 11.0,
                      ),
                    ),
                    Positioned(
                      top: 50.h,
                      right: 20.w,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: 28.h,
                            height: 28.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: appColor),
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: white,
                              ),
                            )),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 20.w,
                      child: InkWell(
                        onTap: () {
                          _getCurrentLocation();
                        },
                        child: Container(
                            width: 28.h,
                            height: 28.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: appColor),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(AppImage.location),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اسم الموقع',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AddressType(
                      index: index,
                      addressType: addressType,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'تفاصيل العنوان',
                      style: TextStyle(fontSize: 14.sp, color: appColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AddressInputTextField(
                      controller: controller,
                      hintText: 'اسم المبني / عنوان الشارع',
                      obSecure: false,
                      color: appColor,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: AppButton(
                                onTap: () async {
                                  SmartDialog.showLoading(
                                    animationBuilder:
                                        (controller, child, animationParam) {
                                      return Loading(
                                          text: ' جاري اضافة العنوان');
                                    },
                                  );
                                  Future.delayed(const Duration(seconds: 2),
                                      () async {
                                    await firebaseServices.addLoaction(
                                        address: controller.text,
                                        addressType: addressType[index],
                                        addressDetails: '',
                                        latitude: '',
                                        longitude: '');
                                    SmartDialog.dismiss();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  });
                                },
                                text: 'حفظ',
                                barder: false)),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: AppButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                text: 'الغاء',
                                barder: true))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15,
          ),
        ),
      );
    }
  }
}
