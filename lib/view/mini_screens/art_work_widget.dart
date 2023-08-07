import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../provider/songmodel_provider.dart';

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({Key? key, this.tag}) : super(key: key);
  final Object? tag;
  @override
  Widget build(BuildContext context) {
    return Consumer<SongModelProvider>(
        builder: (context, value, child) => tag != null
            ? Hero(
                tag: tag!,
                child: QueryArtworkWidget(
                  keepOldArtwork: true,
                  id: value.id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: 200,
                  artworkWidth: 200,
                  artworkFit: BoxFit.cover,
                  nullArtworkWidget: const CircleAvatar(
                    radius: 120,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png',
                    ),
                  ),
                ),
              )
            : QueryArtworkWidget(
              keepOldArtwork: true,
                id: value.id,
                type: ArtworkType.AUDIO,
                artworkHeight: 200,
                artworkWidth: 200,
                artworkFit: BoxFit.cover,
                nullArtworkWidget: const CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png',
                  ),
                ),
              ));
  }
}
