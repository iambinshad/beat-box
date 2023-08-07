import 'package:flutter/material.dart';


class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.bottomCenter,
      child: Container(


        width: 320,
        height: 45,
        decoration: BoxDecoration(border: Border.all(color: Colors.white),color: Colors.red),
        
      
        
    
      ),
    );
  }
}