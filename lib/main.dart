import 'package:beatabox/controller/bottom_nav_controller.dart';
import 'package:beatabox/database/fav_db.dart';
import 'package:beatabox/provider/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:beatabox/provider/home_page_provider/home_provider.dart';
import 'package:beatabox/provider/home_page_provider/search_provider.dart';
import 'package:beatabox/provider/lyrics_provider.dart';
import 'package:beatabox/provider/mini_player_provider/mini_player_prov.dart';
import 'package:beatabox/provider/now_playing_provider/now_playing_pro.dart';
import 'package:beatabox/provider/onboarding_provider/onboarding.dart';
import 'package:beatabox/model/fav_model.dart';
import 'package:beatabox/provider/songmodel_provider.dart';
import 'package:beatabox/view/mini_screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'database/playlist_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(FavModelAdapter().typeId)) {
    Hive.registerAdapter(FavModelAdapter());
  }

  await Hive.initFlutter();
  await Hive.openBox<int>('FavoriteDB');
  await Hive.openBox<FavModel>('playlistDb');

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create:(context) => SongModelProvider(), ),
        ListenableProvider(create: (context) =>OnBoardingProvider(),),
        ListenableProvider(create:(context) => HomePageProvider(), ),
        ListenableProvider(create: (context) => BottomNavProv(),),
        ListenableProvider(create: (context) => SearchProvider(),),
         ListenableProvider(create: (context) => FavoriteDb(),),
         ListenableProvider(create: (context) => NowProvider(),),
         ListenableProvider(create: (context) => PlaylistDb(),),
         ListenableProvider(create: (context) => MiniPlayerProv(),),


        ListenableProvider(
          create: (context) => BottomNavController(),
        ),
        ListenableProvider(
          create: (context) => LyricsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'BeatBox Music Player',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const  Color.fromRGBO(70, 40, 114, 1)))),
          primarySwatch: Colors.blue,
        ),
        home:  const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
