import 'package:beatabox/view/mini_screens/onboarding/onboarding_screen_two.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main_screens/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _visible = true;
      setState(() {});
      await Future.delayed(const Duration(seconds: 3));
      if (context.mounted) {
        gotoHome(context);
      }
      getDataFromSharedPreference();
    });
  }

  late SharedPreferences sharedPreferences;

  dynamic savedValue;

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    'assets/splash-img/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png',
                    height: 220,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gotoHome(context) async {
    if (savedValue == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const OnBoardingScreen();
      }), (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return BottomNavScreen();
      }), (route) => false);
    }
  }

  Future<void> getDataFromSharedPreference() async {
    final sharedprifes = await SharedPreferences.getInstance();

    savedValue = sharedprifes.getInt('enterCount');
  }
}
