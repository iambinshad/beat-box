import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../provider/songmodel_provider.dart';

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: context.watch<SongModelProvider>().id,
      type: ArtworkType.AUDIO,
      artworkHeight: 200,
      artworkWidth: 200,
      keepOldArtwork: true,
      artworkFit: BoxFit.cover,
      nullArtworkWidget: const CircleAvatar(
        radius: 120,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(
          'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png',
        ),
      ),
    );
  }
}
