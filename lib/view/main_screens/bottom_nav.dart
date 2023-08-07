import 'package:beatabox/controller/bottom_nav_controller.dart';
import 'package:beatabox/controller/get_all_song_controller.dart';
import 'package:beatabox/database/fav_db.dart';
import 'package:beatabox/provider/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:beatabox/view/main_screens/playlist/playlist_screen.dart';
import 'package:beatabox/view/mini_screens/min_player.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'favorites/favorite_screen.dart';
import 'home/home/home_screen.dart';
import 'settings/settings_screen.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final pages = [
    const HomeScreen(),
    const FavouriteScreen(),
    const PlaylistScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer3<FavoriteDb, BottomNavProv, BottomNavController>(
        builder: (context, value, value2, value3, child) => Stack(
          children: [
            pages[value2.currentSelectedIndex],
            Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    GetAllSongController.audioPlayer.currentIndex != null
                        ? const Column(
                            children: [MiniPlayer()],
                          )
                        : const SizedBox(),
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40)),
          child: Consumer<BottomNavProv>(
            builder: (context, value, child) => GNav(
                tabBorderRadius: 150,
                tabBackgroundColor: Colors.deepPurple,
                gap: 5,
                haptic: true,
                padding: const EdgeInsets.all(12),
                activeColor: Colors.white,
                color: Colors.white,
                onTabChange: (index) {
                  value.bottomSwitching(index);
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
      ),
    );
  }
}
