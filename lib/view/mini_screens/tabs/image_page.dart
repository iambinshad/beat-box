import 'package:beatabox/view/mini_screens/art_work_widget.dart';
import 'package:flutter/material.dart';

class NowPlayingImagePage extends StatefulWidget {
  NowPlayingImagePage({super.key, this.tag});
  Object? tag;

  @override
  State<NowPlayingImagePage> createState() => _NowPlayingImagePageState();
}

class _NowPlayingImagePageState extends State<NowPlayingImagePage> {
  double heiight = 290;

  double wiidth = 290;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wiidth = 300;
      heiight = 300;
      setState(() {});
    });
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Stack(
        children: [
          Positioned(
            height: 300,
            width: width / 1.3,
            child: ArtWorkWidget(
              tag: widget.tag,
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Colors.grey,
              ),
              height: heiight,
              width: wiidth,
            ),
          )
        ],
      ),
    );
  }
}
