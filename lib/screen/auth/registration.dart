import 'dart:io';

import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/controller/image_controller.dart';
import 'package:brush/screen/auth/widget/text_field.dart';
import 'package:brush/services/firebase_auth.dart';
import 'package:brush/services/phone_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Registration extends StatelessWidget {
  Registration({super.key});
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  List<String> images = [];
  FirebaseAuthServices firebaseService = FirebaseAuthServices();
  final _formKey = GlobalKey<FormState>();
  PhoneService service = PhoneService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Container(
                    width: 28.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: appColor),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: white,
                    )),
              ),
            ),
          ]),
      body: GetBuilder<ImagePickerController>(
          init: ImagePickerController(),
          builder: (controller) {
            return SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                                radius: 50.h,
                                backgroundImage:
                                    const AssetImage(AppImage.user),
                                child: controller.pickedFile != null
                                    ? CircleAvatar(
                                        radius: 49.h,
                                        backgroundImage: FileImage(
                                          File(controller.pickedFile!.path),
                                        ),
                                      )
                                    : null),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Get.bottomSheet(
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(22.0),
                                        child: Column(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                images = await controller
                                                    .pickImage(
                                                        ImageSource.camera)
                                                    .whenComplete(() {
                                                  Get.back();
                                                });
                                              },
                                              child: Text(
                                                'اختر صورة من الكاميرا',
                                                style:
                                                    TextStyle(fontSize: 16.sp),
                                              ),
                                            ),
                                            Divider(
                                              color: appColor,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                images = await controller
                                                    .pickImage(
                                                        ImageSource.gallery)
                                                    .whenComplete(() {
                                                  Get.back();
                                                });
                                              },
                                              child: Text('اختر صورة من المعرض',
                                                  style: TextStyle(
                                                      fontSize: 16.sp)),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  AppImage.add,
                                  height: 25.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InputTextField(
                        keyboardType: TextInputType.phone,
                        color: appColor.withOpacity(0.06),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل رقم الهاتف';
                          }
                          return null;
                        },
                        lable: 'رقم الهاتف',
                        controller: phoneController,
                        hintText: '5678 1234 966+ ',
                        obSecure: false,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      InputTextField(
                        keyboardType: TextInputType.name,
                        color: appColor.withOpacity(0.06),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل الأسم';
                          }
                          return null;
                        },
                        lable: 'الأسم',
                        controller: nameController,
                        hintText: 'الأسم',
                        obSecure: false,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      InputTextField(
                        keyboardType: TextInputType.emailAddress,
                        color: appColor.withOpacity(0.06),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل كلمة المرور';
                          }
                          return null;
                        },
                        lable: 'كلمة المرور',
                        controller: passwordController,
                        hintText: '*********',
                        obSecure: true,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'بالقيام بانشاء حساب فانت توافق علي ',
                              style:
                                  TextStyle(color: appColor, fontSize: 15.sp),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              'الشروط والأحكام',
                              style: TextStyle(
                                color: appColor,
                                fontSize: 15.sp,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 115.h,
                      ),
                      AppButton(
                        barder: false,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            controller.selectedImages.isEmpty
                                ? Get.snackbar(
                                    'خطأ',
                                    'من فضلك اختر صورة',
                                    backgroundColor: Colors.red,
                                  )
                                : await service.verificationPhoneNumber(
                                    context,
                                    phoneController.text,
                                    nameController.text,
                                    passwordController.text,
                                    images[0]);
                          }
                        },
                        text: 'انشاء حساب',
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                    ],
                  ),
                )),
              ),
            );
          }),
    );
  }
}
