import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/constant/widget/loading.dart';
import 'package:brush/constant/widget/logo.dart';
import 'package:brush/model/user.dart';
import 'package:brush/screen/auth/login.dart';
import 'package:brush/screen/auth/widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class CreateNewPassword extends StatelessWidget {
  final UserModel userModel;
  CreateNewPassword({super.key, required this.userModel});
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

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
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            const Logo(),
            SizedBox(
              height: 30.h,
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
              lable: 'كلمة المرور الجديدة',
              controller: passwordController,
              hintText: '*********',
              obSecure: true,
            ),
            SizedBox(
              height: 30.h,
            ),
            AppButton(
              barder: false,
              onTap: () async {
                SmartDialog.showLoading(
                  animationBuilder: (controller, child, animationParam) {
                    return Loading(text: '... تحميل');
                  },
                );
                User user = FirebaseAuth.instance.currentUser!;
                user.updatePassword(passwordController.text).then((_) {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .update({
                    "password": passwordController.text,
                  }).then((_) {
                    Get.snackbar('بنجاح', 'تم تغيير كلمة المرور بنجاح');
                    Get.offAll(() => Login());
                    SmartDialog.dismiss();
                    print("Successfully changed password");
                  });
                }).catchError((error) {
                  print("Error " + error.toString());
                });
              },
              text: 'يتغير كلمة المرور',
            ),
          ]),
        ),
      ),
    );
  }
}
