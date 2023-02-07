import 'package:beatabox/screens/main_screens/playlist/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../database/fav_db.dart';
import 'favorites/favorite_screen.dart';
import 'home/home_screen.dart';
import 'settings/settings_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentSelectedIndex = 0;
  final pages = const [
    HomeScreen(),
    FavouriteScreen(),
    PlaylistScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: FavoriteDb.favoriteSongs,
            builder:
                (BuildContext context, List<SongModel> music, Widget? child) {
              return pages[_currentSelectedIndex];
            }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.deepPurple, width: 2),
              color: Colors.black,
              borderRadius: BorderRadius.circular(40)),
          child: GNav(
              tabBorderRadius: 150,
              tabBackgroundColor: Colors.deepPurple,
              gap: 5,
              haptic: true,
              padding: const EdgeInsets.all(12),
              activeColor: Colors.white,
              color: Colors.white,
              onTabChange: (index) {
                setState(() {
                  _currentSelectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.headphones_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_outline,
                  text: 'Favorite',
                ),
                GButton(
                  icon: Icons.playlist_add_outlined,
                  text: 'Playlist',
                ),
                GButton(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                )
              ]),
        ),
      ),
    );
  }
}
