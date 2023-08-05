
import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            'assets/introPages/intro-img1.png',
            height: 230,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Music is life',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Balances your emotions and make ',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 94, 89, 89)),
          ),
          const Text(
            'you to feel happy',
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
