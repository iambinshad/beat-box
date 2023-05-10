import 'package:beatabox/screens/mini_screens/tabs/lyrics.dart';
import 'package:beatabox/screens/mini_screens/tabs/now_playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingTab extends StatefulWidget {
   const NowPlayingTab({super.key, required this.songModelList, this.count = 0});
     final List<SongModel> songModelList;
  final dynamic count;

  @override
  State<NowPlayingTab> createState() => _NowPlayingTabState();
}

class _NowPlayingTabState extends State<NowPlayingTab> with SingleTickerProviderStateMixin{
@override
  void initState() {
     tabController = TabController(length: 2, vsync:this);
    super.initState();
  }
      // late List<SongModel> songPlaylist;

    @override
  void dispose() {
    if(mounted){tabController.dispose();}
    super.dispose();
  }
 late TabController tabController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     
    });

    return Scaffold(
      appBar: AppBar(title: const   Text(
                              'NOW PLAYING',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  fontFamily: 'poppins'),
                            ),backgroundColor:Color.fromARGB(255, 61, 43, 128),centerTitle: true,bottom:
        TabBar(
         indicatorColor: Colors.deepPurple,
        controller:tabController ,
        tabs:const [
        Tab(text: 'Music',),
            Tab(text: 'Lyrics',),
            
       ]),),
      body: TabBarView(
        controller: tabController,
        
        children:[
        NowPlayingScreen(songModelList: widget.songModelList ,count:widget.count ,),
 const LyricsScreen(),
      ] )
    );
  }
}
