import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:iec_project/Firebase/firebase_options.dart';
import 'package:iec_project/controllers/auth_controller.dart';
import 'package:iec_project/pages/home_page.dart';
import 'package:iec_project/pages/introduction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('✅ Firebase initialized successfully');

    await GetStorage.init(); // Initialize GetStorage first
    Get.put(Authcontroller()); // Then put Authcontroller

    runApp(const MyApp());
  } catch (e, stack) {
    print('❌ Initialization error: $e');
    print('Stack trace: $stack');

    // You can’t use Get.snackbar outside a widget tree, so we log it instead
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Jobify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IntroductionScreen(),
      routes: {
        '/home': (context) =>
            const HomePage(), // Replace with your actual home screen widget
      },
    );
  }
}

// This function checks and updates first-time status
bool isFirstTime() {
  final box = GetStorage();
  final firstTime = box.read('first_time');

  if (firstTime == null || firstTime == true) {
    box.write('first_time', false); // Update for next time
    return true;
  } else {
    return false;
  }
}
