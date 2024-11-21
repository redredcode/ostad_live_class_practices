import 'package:fiixplz/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvancedSettingsScreen extends StatelessWidget {
  const AdvancedSettingsScreen({super.key});

  static const String name = '/advSettings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Science Level Advanced Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Home(),
                //   ),
                //   (predicate) => false,
                // );
                Get.offAll(()=> const Home());
              },
              child: const Text('Home'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const Home(), transition: Transition.zoom); // directly navigating to the Home screen will put a back button on the home screen app bar,
                // which we don't want. That's why we use Navigator.pushAndRemoveUntil or Get.offAll() in GetX
              },
              child: const Text('Home again'),
            ),
          ],
        ),
      ),
    );
  }
}
