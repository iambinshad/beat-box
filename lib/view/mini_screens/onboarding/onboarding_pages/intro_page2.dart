import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            'assets/introPages/intro-img4.png',
            height: 230,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Enjoy Music',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Massive music for you to listen to,',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 94, 89, 89)),
          ),
          const Text(
            'enjoy each moment of music',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 94, 89, 89)),
          )
        ],
      ),
    );
  }
}
