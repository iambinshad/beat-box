import 'package:beatabox/provider/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:beatabox/screens/main_screens/playlist/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'favorites/favorite_screen.dart';
import 'home/home_screen.dart';
import 'settings/settings_screen.dart';

class BottomNavScreen extends StatelessWidget {
   BottomNavScreen({super.key});

  final pages =  [
    HomeScreen(),
    const FavouriteScreen(),
    const PlaylistScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var bottomProv = Provider.of<BottomNavProv>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child:Consumer<BottomNavProv>(builder: (context, value, child) => pages[value.currentSelectedIndex],)
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.deepPurple, width: 2),
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
