import 'package:brush/constant/widget/loading.dart';
import 'package:brush/model/user.dart';
import 'package:brush/screen/auth/login.dart';
import 'package:brush/screen/bottom_nav/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../constant/app_image.dart';

class FirebaseAuthServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  userRegister(email, password, context, image, name, phone,) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(text: '... تحميل');
      },
    );
    try {
        OSDeviceState? status = await OneSignal.shared.getDeviceState();

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          email: email,
          phone: phone,
          password: password,
          image: image,
          name: name,
          uid: userCredential.user!.uid,
          walatBalance: 0,
          token: status!.userId);

      if (userCredential.user!.uid.isNotEmpty) {
        users
            .doc(userCredential.user!.uid)
            .set(userModel.toMap())
            .then((value) => {
                  SmartDialog.dismiss(),
                  Get.snackbar('اشتراك!', 'لقد قمت بالتسجيل بنجاح',
                      backgroundColor: white),
                  Get.offAll(() => const BottomNavigationBars()),
                });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('رفض !', '! الحساب موجود بالفعل لهذا البريد الإلكتروني',
            backgroundColor: white);
        SmartDialog.dismiss();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.toString()} '),
        ),
      );
      SmartDialog.dismiss();
    }
  }

  userLogin(
    email,
    password,
    context,
  ) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(text: '... تحميل');
      },
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
        Get.snackbar('Login !', 'Successfully Login !', backgroundColor: white);
        Get.offAll(() => const BottomNavigationBars());
        SmartDialog.dismiss();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Login !', 'This email is not registor as user.',
            backgroundColor: white);
        SmartDialog.dismiss();
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Password !', 'Wrong Password!', backgroundColor: white);
        SmartDialog.dismiss();
      }
    }
  }

  Future<void> verifyEmail(email) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (!(user!.emailVerified)) {
      await user.sendEmailVerification();
      Get.offAll(() => Login());
    }
  }
}
