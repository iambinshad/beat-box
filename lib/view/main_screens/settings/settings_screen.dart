import 'package:beatabox/view/main_screens/settings/privacy_policy.dart';
import 'package:beatabox/view/main_screens/settings/terms_and_cod.dart';
import 'package:beatabox/view/mini_screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../database/fav_db.dart';
import '../../../model/fav_model.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.black,
        Colors.deepPurple,
        Colors.black,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: 'poppins',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutScreen(),
                          ));
                    },
                    child: const ListSettings(
                      titleText: 'About BeatBox',
                      yourIcon: Icons.info_outline,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen(),
                          ));
                    },
                    child: const ListSettings(
                      titleText: 'Privacy Policy',
                      yourIcon: Icons.privacy_tip_outlined,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TermsAndConditionScreen(),
                          ));
                    },
                    child: const ListSettings(
                      titleText: 'Terms and Conditions',
                      yourIcon: Icons.gavel_rounded,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      resetalert(context);
                    },
                    child: const ListSettings(
                        titleText: 'Reset', yourIcon: (Icons.restore)),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Share.share(
                          'hey! check out this new app https://play.google.com/store/search?q=music%20application&c=apps');
                    },
                    child: const ListSettings(
                      titleText: 'Share BeatBox',
                      yourIcon: Icons.share_outlined,
                    ),
                  ),
                  SizedBox(
                    height: height / 4,
                  ),
                  const Center(
                      child: Text(
                    'Version 2.0.0',
                    style: TextStyle(color: Colors.grey),
                  )),
                ],
              ),
            )),
      ),
    );
  }

  void resetalert(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 52, 6, 105),
          title: const Text(
            'Reset BeatBox',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text('Are you sure you want to reset this application',
              style: TextStyle(color: Colors.white)),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                      color: Colors.purpleAccent, fontFamily: 'poppins'),
                )),
            ElevatedButton(
                onPressed: () async {
                  final sharedprifes = await SharedPreferences.getInstance();
                  await sharedprifes.clear();
                  if (context.mounted) {
                    Provider.of<FavoriteDb>(context, listen: false).clear();
                  }
                  final playlistDb = Hive.box<FavModel>('playlistDb');
                  await playlistDb.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return const SplashScreen();
                    },
                  ), (route) => false);
                },
                child: const Text('Yes',
                    style: TextStyle(
                        color: Colors.purpleAccent, fontFamily: 'poppins')))
          ],
        );
      },
    );
  }
}

class ListSettings extends StatelessWidget {
  const ListSettings({
    Key? key,
    required this.titleText,
    required this.yourIcon,
  }) : super(key: key);

  final String titleText;
  final IconData yourIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        color: Colors.black12,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Color.fromARGB(255, 111, 111, 193))),
        child: ListTile(
          iconColor: Colors.white,
          selectedColor: Colors.purpleAccent,
          leading: Icon(yourIcon),
          title: Text(
            titleText,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'poppins',
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
