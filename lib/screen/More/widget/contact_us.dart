import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/More/widget/more_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path:
          'recipient@example.com', // Replace with the recipient's email address
      queryParameters: {
        'subject': 'Hello from Flutter', // Email subject
        'body': 'This is the body of the email.', // Email body
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      // Handle error: Unable to launch email
    }
  }

  void sendWhatsAppMessage() async {
    const phoneNumber = '+966123456789';
    const message = 'Hello from Flutter';

    final whatsappUrl =
        'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {}
  }

  void makePhoneCall() async {
    const phoneNumber = '+966123456789';
    const telUrl = 'tel:$phoneNumber';
    if (await canLaunch(telUrl)) {
      await launch(telUrl);
    } else {
      // Handle error: Unable to launch phone call
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'تواصل معنا',
            style: TextStyle(color: appColor),
          ),
          centerTitle: true,
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
        child: Column(
          children: [
            Image.asset('assets/icons/Group 2175.png'),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.whatapp,
              title: 'واتساب',
              onTap: () {
                sendWhatsAppMessage();
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.mail,
              title: 'الأيميل',
              onTap: () {
                sendEmail();
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.call,
              title: 'اتصال',
              onTap: () {
                makePhoneCall();
              },
            ),
            const Spacer(),
            Text(
              'تابعنا علي',
              style:
                  TextStyle(color: appColor.withOpacity(0.5), fontSize: 18.sp),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.tiktok,
                      height: 25.h,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.insta,
                      height: 25.h,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.sanpchat,
                      height: 25.h,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.twitter,
                      height: 25.h,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
