import 'package:beatabox/screens/mini_screens/art_work_widget.dart';
import 'package:flutter/material.dart';

class NowPlayingImagePage extends StatelessWidget {
  NowPlayingImagePage({super.key, this.tag});
  Object? tag;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Stack(
        children: [
          Positioned(
            height: 300,
            width: width / 1.3,
            child: ArtWorkWidget(
              tag: tag,
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Colors.grey,
              ),
              height: 300,
              width: width / 1.3,
            ),
          )
        ],
      ),
    );
  }
}
