import 'package:beatabox/provider/lyrics_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LyricsScreen extends StatelessWidget {
  const LyricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Consumer<LyricsProvider>(
        builder: (context, value, child) => SingleChildScrollView(
            child: value.allData?.message?.body?.lyrics?.lyricsBody != null
                ? Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        value.allData!.message!.body!.lyrics!.lyricsBody
                            .toString()
                            .replaceAll(
                                "******* This Lyrics is NOT for Commercial use *******",
                                ""),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            wordSpacing: 3,
                            letterSpacing: 1.3,
                            height: 1.5),
                      ),
                    ),
                  )
                : Center(
                    child: context.watch<LyricsProvider>().isLoading == true
                        ? const CircularProgressIndicator()
                        : const Text("Lyrics Not Found!",style: TextStyle(color: Colors.white),),
                  )),
      ),
    );
  }
}
