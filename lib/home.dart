import 'package:fiixplz/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'counter_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const String name = '/';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<CounterController>(
              builder: (counterController) {
                return Text(
                  '${counterController.counter}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const SettingsScreen(),
                //   ),
                // );
                //Navigator.pushNamed(context, SettingsScreen.name);
                Get.toNamed(SettingsScreen.name);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/settings', (predicate) => false);
                // Get.to(const SettingsScreen(), transition: Transition.rightToLeft);
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.showSnackbar(
                  const GetSnackBar(
                    title: 'GetX SnackBar',
                    message:
                        'GetX SnackBar is way more convenient than flutter snackBar',
                    duration: Duration(seconds: 3),
                    icon: Icon(Icons.notifications_active, color: Colors.white,),
                    snackPosition: SnackPosition.TOP,
                  ),
                );
              },
              child: const Text('Show Snack Bar'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<CounterController>().increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
