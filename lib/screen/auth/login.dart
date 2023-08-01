import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/constant/widget/logo.dart';
import 'package:brush/controller/user_controller.dart';
import 'package:brush/screen/auth/registration.dart';
import 'package:brush/screen/auth/reset_pass.dart';
import 'package:brush/screen/auth/widget/text_field.dart';
import 'package:brush/services/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  UserController userController = Get.put(UserController());
  FirebaseAuthServices firebaseService = FirebaseAuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Logo(),
              SizedBox(
                height: 30.h,
              ),
              InputTextField(
                keyboardType: TextInputType.phone,
                color: appColor.withOpacity(0.06),
                change: (value) {
                  userController.getSpecificUserByPhone(phoneController.text);
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
                keyboardType: TextInputType.emailAddress,
                color: appColor.withOpacity(0.06),
                lable: 'كلمة المرور',
                controller: passwordController,
                hintText: '*********',
                obSecure: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => ResetPassword());
                    },
                    child: Text(
                      'هل نسيت كلمة المرور؟',
                      style: TextStyle(color: appColor, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              AppButton(
                barder: false,
                onTap: () async {
                  await firebaseService
                      .userLogin(userController.specificUser.value.email,
                          passwordController.text, context)
                      .then((value) async {
                    OSDeviceState? status =
                        await OneSignal.shared.getDeviceState();
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userController.specificUser.value.uid)
                        .update({'token': status!.userId});
                  });

                  // Get.offAll(() => const BottomNavigationBars());
                },
                text: 'تسجيل الدخول',
              ),
              SizedBox(
                height: 12.h,
              ),
              AppButton(
                barder: true,
                onTap: () {
                  Get.to(() => Registration());
                },
                text: 'انشاء حساب',
              ),
              SizedBox(
                height: 70.h,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'الشروط والأحكام',
                    style: TextStyle(
                        color: appColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
