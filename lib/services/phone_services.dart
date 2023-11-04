import 'package:brush/constant/widget/loading.dart';
import 'package:brush/model/user.dart';
import 'package:brush/screen/auth/otp.dart';
import 'package:brush/screen/auth/widget/reset_password_otp.dart';
import 'package:brush/services/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';

class PhoneService {
  FirebaseAuthServices service = FirebaseAuthServices();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  verificationPhoneNumber(
      BuildContext context, number, name, password, image,lat,log,address,cityName) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(text: '... تحميل');
      },
    );

    verificationCompleted(PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    }

    verificationFailed(FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {}
    }

    Future<void> codeSent(String verId, int? resendToken) async {
      SmartDialog.dismiss();
      await Get.to(() => OTP(
        cityName:cityName ,
            number: number,
            verId: verId,
            password: password,
            name: name,
            image: image,
            latitude: lat,
            longitude: log,
            address: address,
          ));
    }

    try {
      auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {}
  }

  verificationPhoneNumberResetPassword(
    BuildContext context,
    number,
    UserModel userModel,
  ) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(text: '... تحميل');
      },
    );

    verificationCompleted(PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    }

    verificationFailed(FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {}
    }

    Future<void> codeSent(String verId, int? resendToken) async {
      SmartDialog.dismiss();
      await Get.to(() => ResetOTP(
            userModel: userModel,
            number: number,
            verId: verId,
          ));
    }

    try {
      auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {}
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
