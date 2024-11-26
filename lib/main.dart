import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      initialRoute: '/',
      routes: {
        //Home.name : (context) => const Home(),
        // SettingsScreen.name : (context) => const SettingsScreen(),
        // ProfileScreen.name : (context) => const ProfileScreen(),
        // AdvancedSettingsScreen.name : (context) => const AdvancedSettingsScreen(),
      },
      //initialBinding: ControllerBinder(),
    );
  }
}

// class ControllerBinder extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(CounterController());
//   }
// }