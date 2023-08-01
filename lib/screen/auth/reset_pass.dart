import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/constant/widget/logo.dart';
import 'package:brush/controller/user_controller.dart';
import 'package:brush/screen/auth/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/phone_services.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  PhoneService service = PhoneService();
  UserController userController = Get.put(UserController());
  final formKey = GlobalKey<FormState>();

  int index = 0;
  bool isShow = false;
  bool obsecure = true;

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
      body: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: const Color(0x00000000),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل رقم الهاتف';
                      }
                      return null;
                    },
                    change: (value) {
                      userController
                          .getSpecificUserByPhone(phoneController.text);
                      return null;
                    },
                    lable: 'رقم الهاتف',
                    controller: phoneController,
                    hintText: '5678 1234 966+ ',
                    obSecure: false,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  AppButton(
                    barder: false,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await service.verificationPhoneNumberResetPassword(
                          context,
                          phoneController.text,
                          userController.specificUser.value,
                        );
                      }
                    },
                    text: 'التحقق من الرقم',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
