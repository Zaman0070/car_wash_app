import 'package:brush/constant/app_image.dart';
import 'package:brush/model/order_Model.dart';
import 'package:brush/screen/MyOrder/widget/order_detail_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyOrderDetails extends StatefulWidget {
  final OrderModel orderModel;
  const MyOrderDetails({super.key, required this.orderModel});

  @override
  State<MyOrderDetails> createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'طلباتي',
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              OrderDetailSection(
                orderModel: widget.orderModel,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'الموقع',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 355.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      _controller = controller;
                      _getLocation();
                    },
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(0, 0),
                      zoom: 11.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late double lat = double.parse(widget.orderModel.latitude!);
  late double long = double.parse(widget.orderModel.longitude!);
  void _getLocation() async {
    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, long),
            zoom: 15,
          ),
        ),
      );
    }
  }
}
