import 'package:fiixplz/advanced_settings_screen.dart';
import 'package:fiixplz/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String name = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ProfileScreen(),
                //   ),
                // );
                Get.off(()=> const ProfileScreen(),);
              },
              child: const Text('Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                Get.back();
              },
              child: const Text('Home'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(()=> const AdvancedSettingsScreen());
              },
              child: const Text('Rocket Science Level Advanced Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
