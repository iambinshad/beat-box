import 'package:beatabox/provider/lyrics_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class LyricsScreen extends StatelessWidget {
  const LyricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
       decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.deepPurple,
          Color.fromARGB(255, 61, 43, 128),
        ],
      )),
      child: Scaffold(
      backgroundColor: Colors.transparent,
 
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Consumer<LyricsProvider>(
          builder: (context, value, child) => 
           SingleChildScrollView(
            child:  Card(
              child: Center(child:value.allData?.message?.body?.lyrics?.lyricsBody!=null?Text(value.allData!.message!.body!.lyrics!.lyricsBody.toString().replaceAll("******* This Lyrics is NOT for Commercial use *******", ""),style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  height: 1.5),):const Text("Lyrics Not Found!"),
              ),
            ),
            // child: Text(
            //   lyrics,
            //   style: 
              ),
        ),
          ),
        ),
      );
    

    
  }
}