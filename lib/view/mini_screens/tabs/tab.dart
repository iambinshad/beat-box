
import 'package:beatabox/view/mini_screens/tabs/lyrics.dart';
import 'package:beatabox/view/mini_screens/tabs/now_playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingTab extends StatefulWidget {
  const NowPlayingTab({super.key, required this.songModelList, this.count = 0});
  final List<SongModel> songModelList;
  final dynamic count;

  @override
  State<NowPlayingTab> createState() => _NowPlayingTabState();
}

class _NowPlayingTabState extends State<NowPlayingTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'NOW PLAYING',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'poppins'),
          ),
          backgroundColor: const Color.fromARGB(255, 61, 43, 128),
          centerTitle: true,
        ),
        body: TabBarView(controller: tabController, children: [
          NowPlayingScreen(
            songModelList: widget.songModelList,
            count: widget.count,
          ),
          const LyricsScreen(),
        ]));
  }
}
