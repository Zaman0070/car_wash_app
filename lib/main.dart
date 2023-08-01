import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/auth/login.dart';
import 'package:brush/screen/bottom_nav/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: appColor.withOpacity(0.2), // status bar color
  ));
  runApp(const MyApp());
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId('af89898f-3ff7-449b-b975-dfa2790f2bea');
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    debugPrint('Accepted permission: $accepted');
  });
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
    debugPrint('OneSignal: notification opened: ${result.notification.body}');
    if (result.notification.additionalData!['type'] == 'mishtri') {}
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    debugPrint('FOREGROUND HANDLER CALLED WITH: ${event}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
          debugShowCheckedModeBanner: false,
          title: 'Car Wash',
          home: child,
        );
      },
      child: FirebaseAuth.instance.currentUser == null
          ? Login()
          : const BottomNavigationBars(),
    );
  }
}
