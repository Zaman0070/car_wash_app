import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/controller/home_controller.dart';
import 'package:brush/screen/auth/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddWaletBalnce extends StatefulWidget {
  const AddWaletBalnce({super.key});

  @override
  State<AddWaletBalnce> createState() => _AddWaletBalnceState();
}

class _AddWaletBalnceState extends State<AddWaletBalnce> {
  HomeController homeController = Get.put(HomeController());
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'إضافة رصيد المحفظة',
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
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              InputTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك أدخل الرصيد';
                  }
                  return null;
                },
                controller: controller,
                hintText: 'أدخل الرصيد',
                lable: 'توازن',
                obSecure: false,
                color: white,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      homeController.addBalance(int.parse(controller.text));
                    }
                  },
                  text: 'إضافة رصيد المحفظة',
                  barder: false),
            ],
          ),
        ),
      ),
    );
  }
}
