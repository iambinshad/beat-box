
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../database/fav_db.dart';

class FavButMusicPlaying extends StatelessWidget {
  const FavButMusicPlaying({super.key, required this.songFavoriteMusicPlaying});
  final SongModel songFavoriteMusicPlaying;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteDb>(
        
        builder:
            (context, value, child) {
          return IconButton(
            onPressed: () {
              if (value.isFavor(songFavoriteMusicPlaying)) {
                value.delete(songFavoriteMusicPlaying.id);
                const snackBar = SnackBar(
                  content: Text(
                    'Removed From Favorite',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(milliseconds: 1500),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                value.add(songFavoriteMusicPlaying);
                const snackbar = SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(
                    'Song Added to Favorite',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(milliseconds: 350),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }

              
            },
            icon: value.isFavor(songFavoriteMusicPlaying)
                ? const Icon(
                  
                    Icons.favorite,
                    color: Colors.purpleAccent,
                    size: 30,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    color: Colors.purpleAccent,
                    size: 30,
                  ),
          );
        });
  }
}
