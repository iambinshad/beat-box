import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main_screens/bottom_nav.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  late SharedPreferences sharedPreferences;

  dynamic savedValue;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gotoHome(context);
      getDataFromSharedPreference();
    });
    getDataFromSharedPreference();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 160, 25, 165),
        Color.fromARGB(255, 38, 75, 149)
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Stack(children: [
                    const Positioned(
                        bottom: -7,
                        left: 33,
                        child: Text(
                          'BEATBOX',
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
                    Image.asset(
                      'assets/splash-img/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png',
                      height: 200,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gotoHome(context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (savedValue == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return OnBoardingScreen();
      }), (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const BottomNavScreen();
      }), (route) => false);
    }
  }

  Future<void> getDataFromSharedPreference() async {
    final sharedprifes = await SharedPreferences.getInstance();

    savedValue = sharedprifes.getInt('enterCount');
  }
}
