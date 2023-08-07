import 'package:beatabox/provider/onboarding_provider/onboarding.dart';
import 'package:beatabox/view/main_screens/bottom_nav.dart';
import 'package:beatabox/view/mini_screens/onboarding/onboarding_pages/intro_page1.dart';
import 'package:beatabox/view/mini_screens/onboarding/onboarding_pages/intro_page2.dart';
import 'package:beatabox/view/mini_screens/onboarding/onboarding_pages/intro_page3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
    @override
  void initState() {
    super.initState();
    reqeustStoragePermission();
  }
  int? enter = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Provider.of<OnBoardingProvider>(context).skipbutton
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
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
                      ),
              ],
            ),
            const SizedBox(),
            Consumer<OnBoardingProvider>(
              builder: (context, value, child) {
                return SizedBox(
                  height: context.height / 1.7,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: _controller,
                          onPageChanged: (index) {
                            value.isLastPage(index);
                          },
                          children: const [
                            IntroPage1(),
                            IntroPage2(),
                            IntroPage3(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(controller: _controller, count: 3),
                
                // GestureDetector(
                //             onTap: () {
                             
                //             },
                //             child: Container(
                //               margin: EdgeInsets.all(0),
                //               padding: EdgeInsets.all(0),
                //               decoration: BoxDecoration(
                //                   color:
                //                       const Color.fromARGB(255, 117, 88, 210),
                //                   borderRadius: BorderRadius.circular(7)),
                //               height: 40,
                //               width: 150,
                //               child: const Center(
                //                   child: Text(
                //                 'Get Started',
                //                 style: TextStyle(
                //                     fontSize: 17,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w500),
                //               )),
                //             ),
                //           );
                Provider.of<OnBoardingProvider>(context).getStarted
                    ? Consumer<OnBoardingProvider>(
                        builder: (context, value, child) {
                          return SliderButton(
                  buttonColor: const Color.fromARGB(255, 117, 88, 210),
                  width: 200,
                  height: 60,
                  action: () {
               value.entryCounting();

                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return BottomNavScreen();
                              }), (route) => false);
                  },
                  label: const Text(
                "Slide To Get Started",
                style: TextStyle(
                    color: Color(0xff4a4a4a),
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
                  ),
                  icon: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,)
                );
                        },
                      )
                    :  SizedBox(
                        height: 65,
                        width: context.width/ 2,
                        child: null,
                      ),
                Provider.of<OnBoardingProvider>(context).onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return BottomNavScreen();
                          }), (route) => false);
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: null,
                        ))
                    : GestureDetector(
                        onTap: () => _controller.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeIn),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color.fromARGB(255, 117, 88, 210),
                          child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }
    Future<void> saveEnterCountTosharedPrference() async {
    //Shared Preference
    final sharedprefs = await SharedPreferences.getInstance();
    //save enterence
    await sharedprefs.setInt('enterCount', enter!);
  }

  Future<void> reqeustStoragePermission() async {
    Permission.storage.request();
  }
}
