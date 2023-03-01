import 'package:beatabox/provider/onboarding_provider/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../main_screens/bottom_nav.dart';
import 'onboarding_pages/intro_page1.dart';
import 'onboarding_pages/intro_page2.dart';
import 'onboarding_pages/intro_page3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   bool skipbutton = false;
  bool onLastPage = false;
  bool getStarted = false;
  int? enter = 0;
  final PageController _controller = PageController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<OnBoardingProvider>(builder: (context, value, child) {
              return PageView(
              controller: _controller,
              onPageChanged: (index) {
               
                  setState(() {
                    onLastPage = (index == 2);
                  skipbutton = (index == 2);
                  getStarted = (index == 2);
                  });
                
              },
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
              ],
            );
            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: skipbutton
                      ? null
                      : Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 117, 88, 210)),
                          child: Center(
                              child: GestureDetector(
                            onTap: () {
                              _controller.jumpToPage(2);
                            },
                            child: const Text(
                              'skip',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                        ),
                )
              ],
            ),
            getStarted
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 420),
                            child: Consumer<OnBoardingProvider>(
                              builder: (context, value, child) {
                                return GestureDetector(
                                  onTap: () {
                                    value.entryCounting();
                                    reqeustStoragePermission();
                                    
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const BottomNavScreen();
                                    }), (route) => false);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 117, 88, 210),
                                        borderRadius: BorderRadius.circular(7)),
                                    height: 40,
                                    width: 150,
                                    child: const Center(
                                        child: Text(
                                      'Get Started',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Container(
                    child: null,
                  ),
            Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child:
                        SmoothPageIndicator(controller: _controller, count: 3),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: onLastPage
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return const BottomNavScreen();
                              }), (route) => false);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: null,
                            ))
                        : GestureDetector(
                            onTap: () => _controller.nextPage(
                                duration: const Duration(microseconds: 500),
                                curve: Curves.easeIn),
                            child: const CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 117, 88, 210),
                              child: Icon(Icons.arrow_forward_ios),
                            )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> reqeustStoragePermission() async {
    Permission.storage.request();
  }

  Future<void> saveEnterCountTosharedPrference() async {
    //Shared Preference
    final sharedprefs = await SharedPreferences.getInstance();
    //save enterence
    await sharedprefs.setInt('enterCount', enter!);
  }
}
