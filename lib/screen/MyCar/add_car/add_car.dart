import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/controller/image_controller.dart';
import 'package:brush/screen/MyCar/add_car/widget/add_car_model.dart';
import 'package:brush/screen/MyCar/add_car/widget/bottom_sheet.dart';
import 'package:brush/screen/MyCar/add_car/widget/car_color.dart';
import 'package:brush/screen/MyCar/add_car/widget/car_plates.dart';
import 'package:brush/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/add_car_controller.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final List _items = [
    'فراري',
    'مارسيديس',
    'فورد',
    'تيوتا',
    'ايدي',
    'بي ام دابليو',
  ];
  final List model = [
    'كورولا',
    'كورفيت',
    'تاتا نيكسون',
    'شيفروليه كروز',
    'كامري',
    'سيفيك',
    'كامارو',
  ];
  final List images = [
    'assets/model/Ferrari.png',
    'assets/model/Mercedes.png',
    'assets/model/Ford.png',
    'assets/model/Toyota.png',
    'assets/model/AUDI.png',
    'assets/model/BMW.png',
  ];
  final int _selectedItemIndex = 2;
  final int _selectedItemIndex2 = 2;

  List<Color> color = [
    const Color(0xff15AEA9),
    Colors.white.withOpacity(0.9),
    const Color(0xff000000),
    const Color(0xffAE7615),
    const Color(0xffC9BD10),
    const Color(0xff15AE62),
    const Color(0xff151AAE),
    const Color(0xff750D8E),
    const Color(0xffAE1539),
  ];
  final List<String> cars = [
    'assets/icons/car_o.png',
    'assets/icons/car_o.png',
    'assets/icons/car_o.png',
    'assets/icons/car_o.png',
    'assets/icons/car_o.png',
    'assets/icons/car_o.png',
    'assets/icons/car_o.png',
    'assets/icons/car_o.png',
    'assets/icons/car_o.png',
  ];
  final List<String> colorName = [
    'تيفاني',
    'أبيض',
    'اسود',
    'بني',
    'اصفر',
    'اخضر',
    'ازرق',
    'بنفسجي',
    'احمر',
  ];

  final platNumberController = TextEditingController();
  final paintingController = TextEditingController();
  AddCarController addCarController = Get.put(AddCarController());
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'سياراتي',
          style: TextStyle(color: appColor),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ماركة و موديل السيارة',
                        style: TextStyle(
                          color: appColor,
                          fontSize: 16,
                        )),
                    SizedBox(height: 10.h),
                    Obx(() {
                      return AddCarModel(
                        brand: () {
                          Get.bottomSheet(BottomSheets(
                            isBrand: true,
                            image: images,
                            selectedItemIndex: _selectedItemIndex,
                            item: _items,
                          ));
                        },
                        model: () {
                          Get.bottomSheet(BottomSheets1(
                            isBrand: true,
                            selectedItemIndex: _selectedItemIndex2,
                            item: model,
                          ));
                        },
                        brandName: _items[addCarController.brandIndex.value],
                        image: images[addCarController.brandIndex.value],
                        modelNmae: model[addCarController.modelIndex.value],
                      );
                    }),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('اختر لون السيارة',
                            style: TextStyle(
                              color: appColor,
                              fontSize: 16,
                            )),
                        Obx(() {
                          return Text(
                              colorName[addCarController.colorIndex.value],
                              style: TextStyle(
                                color: appColor,
                                fontSize: 16,
                              ));
                        }),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    CarColor(
                      images: cars,
                      color: color,
                      name: colorName,
                      onTap: () {},
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('رقم اللوحة',
                                style: TextStyle(
                                  color: appColor,
                                  fontSize: 16,
                                )),
                            SizedBox(width: 5.w),
                            Text('(اختياري)',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        Image.asset(
                          AppImage.info,
                          height: 22.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    CarPlates(
                        plateNumber: platNumberController,
                        painting: paintingController),
                    SizedBox(height: 20.h),
                    AppButton(
                        onTap: () async {
                          await imagePickerController.uploadAssetImages([
                            images[addCarController.brandIndex.value]
                          ]).whenComplete(() async {
                            await firebaseServices.addCarToFirebase(
                                colorIndex: addCarController.colorIndex.value,
                                brandIndex: addCarController.brandIndex.value,
                                modelIndex: addCarController.modelIndex.value,
                                brand:
                                    _items[addCarController.brandIndex.value],
                                model: model[addCarController.modelIndex.value],
                                color: colorName[
                                    addCarController.colorIndex.value],
                                plateNumber: platNumberController.text,
                                image: imagePickerController.downloadURL.value,
                                painting: paintingController.text);
                          });
                        },
                        text: 'إضافة',
                        barder: false)
                  ]),
            ),
          )),
    );
  }
}
