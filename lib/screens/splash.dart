import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music/screens/getstarted.dart';
import 'package:music/screens/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/dbsongs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchSongs();
    navigate();
  }

  final box = MusicBox.getInstance();
  final player = AssetsAudioPlayer.withId("0");
  final _audioQuery = OnAudioQuery();

  List<Audio> fullSongs = [];
  // String playlistName = '';
  List<LocalSongs> mappedSongs = [];
  List<LocalSongs> dbSongs = [];
  List<SongModel> fetchedSongs = [];
  List<SongModel> allSongs = [];

  fetchSongs() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    fetchedSongs = await _audioQuery.querySongs();

    for (var element in fetchedSongs) {
      if (element.fileExtension == "mp3") {
        allSongs.add(element);
      }
    }

    mappedSongs = allSongs
        .map(
          (audio) => LocalSongs(
            title: audio.title,
            artist: audio.artist,
            uri: audio.uri,
            duration: audio.duration,
            id: audio.id,
          ),
        )
        .toList();

    await box.put("musics", mappedSongs);
    dbSongs = box.get("musics") as List<LocalSongs>;

    for (var element in dbSongs) {
      fullSongs.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist),
        ),
      );
    }
    setState(() {});
  }

  navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          allSong: fullSongs,
          // playlistName: playlistName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/json/splash.json'),
      ),
    );
  }
}
