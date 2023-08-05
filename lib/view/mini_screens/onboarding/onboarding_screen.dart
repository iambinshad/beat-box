// import 'package:beatabox/provider/onboarding_provider/onboarding.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../../main_screens/bottom_nav.dart';
// import 'onboarding_pages/intro_page1.dart';
// import 'onboarding_pages/intro_page2.dart';
// import 'onboarding_pages/intro_page3.dart';

// class OnBoardingScreen extends StatefulWidget {
//    OnBoardingScreen({super.key});

//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }

// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     reqeustStoragePermission();
//   }
//   int? enter = 0;

//   final PageController _controller = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Consumer<OnBoardingProvider>(
//             builder: (context, value, child) {
//               return PageView(
//                 controller: _controller,
//                 onPageChanged: (index) {
//                   value.isLastPage(index);
//                 },
                
//                 children: const [
//                   IntroPage1(),
//                   IntroPage2(),
//                   IntroPage3(),
//                 ],
//               );
//             },
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//              Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Provider.of<OnBoardingProvider>(context).skipbutton
//                       ? null
//                       : Container(
//                           height: 25,
//                           width: 50,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: const Color.fromARGB(255, 117, 88, 210)),
//                           child: Center(
//                               child: GestureDetector(
//                             onTap: () {
//                               _controller.jumpToPage(2);
                               
//                             },
//                             child: const Text(
//                               'skip',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           )),
//                         ),
//                 ),
//             ],
//           ),
//           Provider.of<OnBoardingProvider>(context).getStarted
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 420),
//                           child: Consumer<OnBoardingProvider>(
//                             builder: (context, value, child) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   value.entryCounting();
                                 

//                                   Navigator.pushAndRemoveUntil(context,
//                                       MaterialPageRoute(builder: (context) {
//                                     return  BottomNavScreen();
//                                   }), (route) => false);
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: const Color.fromARGB(
//                                           255, 117, 88, 210),
//                                       borderRadius: BorderRadius.circular(7)),
//                                   height: 40,
//                                   width: 150,
//                                   child: const Center(
//                                       child: Text(
//                                     'Get Started',
//                                     style: TextStyle(
//                                         fontSize: 17,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500),
//                                   )),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 )
//               : Container(
//                   child: null,
//                 ),
//           Container(
//             alignment: const Alignment(0, 0.75),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 100),
//                   child:
//                       SmoothPageIndicator(controller: _controller, count: 3),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 25),
//                   child: Provider.of<OnBoardingProvider>(context).onLastPage
//                       ? GestureDetector(
//                           onTap: () {
//                             Navigator.pushAndRemoveUntil(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return  BottomNavScreen();
//                             }), (route) => false);
//                           },
//                           child: const CircleAvatar(
//                             backgroundColor: Colors.transparent,
//                             child: null,
//                           ))
//                       : GestureDetector(
//                           onTap: () => _controller.nextPage(
//                               duration: const Duration(microseconds: 500),
//                               curve: Curves.easeIn),
//                           child: const CircleAvatar(
//                             backgroundColor:
//                                 Color.fromARGB(255, 117, 88, 210),
//                             child: Icon(Icons.arrow_forward_ios),
//                           )),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }


// }
