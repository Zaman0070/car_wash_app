import 'dart:async';
import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/constant/widget/loading.dart';
import 'package:brush/constant/widget/logo.dart';
import 'package:brush/model/user.dart';
import 'package:brush/screen/auth/widget/create_new_password.dart';
import 'package:brush/screen/auth/widget/otp_input.dart';
import 'package:brush/services/firebase_auth.dart';
import 'package:brush/services/phone_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ResetOTP extends StatefulWidget {
  final String? number;
  final String? verId;
  final UserModel userModel;
  const ResetOTP({
    super.key,
    this.number,
    required this.userModel,
    this.verId,
  });
  @override
  State<ResetOTP> createState() => _LoginPageState();
}

class _LoginPageState extends State<ResetOTP> {
  String error = '';
  late Timer _timer;
  int _start = 60;
  FirebaseAuthServices firebaseService = FirebaseAuthServices();
  final PhoneService _phoneService = PhoneService();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  Future<void> phoneCredential(BuildContext context, String otp) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      SmartDialog.showLoading(
        animationBuilder: (controller, child, animationParam) {
          return Loading(text: '... تحميل');
        },
      );
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verId!, smsCode: otp);
      // need to oto validate or no

      final authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        FirebaseAuth.instance.currentUser!.delete().whenComplete(() async {
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: '${widget.number}@gmail.com',
                    password: widget.userModel.password!);
            if (userCredential.user!.uid.isNotEmpty) {
              Get.offAll(() => CreateNewPassword(
                    userModel: widget.userModel,
                  ));
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              Get.snackbar('Error', 'This Number is not registor as user.',
                  backgroundColor: white);
            } else if (e.code == 'wrong-password') {
              Get.snackbar('Password !', 'Wrong Password!',
                  backgroundColor: white);
            }
          }
        });

        SmartDialog.dismiss();
      } else {
        print('login Failed');
        if (mounted) {
          setState(() {
            error = 'login failed';
          });
        }
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        setState(() {
          error = 'Invalid OTP';
        });
      }
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
             const Logo(),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OtpInput(_fieldOne, true),
                    ),
                    Expanded(
                      child: OtpInput(_fieldTwo, false),
                    ),
                    Expanded(
                      child: OtpInput(_fieldThree, false),
                    ),
                    Expanded(child: OtpInput(_fieldFour, false)),
                    Expanded(child: OtpInput(_fieldFive, false)),
                    Expanded(child: OtpInput(_fieldSix, false)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$_start ثانية',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: appColor),
                    ),
                    const Text(
                      'يرجي ادخال رمز التحقق المرسل الي هاتفك',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                AppButton(
                  text: 'التالي',
                  onTap: () {
                    if (_fieldOne.text.length == 1) {
                      if (_fieldTwo.text.length == 1) {
                        if (_fieldThree.text.length == 1) {
                          if (_fieldFour.text.length == 1) {
                            if (_fieldFive.text.length == 1) {
                              String _otp = '${_fieldOne.text}${_fieldTwo.text}'
                                  '${_fieldThree.text}${_fieldFour.text}'
                                  '${_fieldFive.text}${_fieldSix.text}';

                              setState(() {
                                phoneCredential(context, _otp)
                                    .whenComplete(() {});
                              });

                              // login
                            }
                          }
                        }
                      }
                    } else {}
                  },
                  barder: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _start = 60;
                      startTimer();
                    });
                    _phoneService.verificationPhoneNumberResetPassword(
                      context,
                      widget.number,
                      widget.userModel,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: appColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'إعادة ارسال الرمز',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: appColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('تم تأكيد الدخول'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'وسيط ',
                        style: TextStyle(color: appColor),
                      ),
                      const Text('مرحباً بك في تطبيق'),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
