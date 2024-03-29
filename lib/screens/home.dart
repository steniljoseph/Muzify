// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music/screens/library.dart';
import 'package:music/screens/musiclist.dart';
import 'package:music/screens/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swipe_to/swipe_to.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  List<Audio> allSong;

  HomePage({
    Key? key,
    required this.allSong,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");
  final audioQuery = OnAudioQuery();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      MusicList(
        fullSongs: widget.allSong,
      ),
      SearchScreen(
        fullSongs: const [],
      ),
      const Library(),
    ];
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicPlayerScreen(
                index: 0,
                fullSongs: widget.allSong,
              ),
            ),
          );
        }),
        child: SizedBox(
          height: 60,
          child: assetAudioPlayer.builderCurrent(
            builder: (BuildContext context, Playing? playing) {
              final myAudio =
                  find(widget.allSong, playing!.audio.assetAudioPath);
              return Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      child: QueryArtworkWidget(
                        id: int.parse(myAudio.metas.id!),
                        type: ArtworkType.AUDIO,
                        artworkBorder:
                            const BorderRadius.all(Radius.circular(28)),
                        artworkFit: BoxFit.cover,
                        nullArtworkWidget: const Icon(FontAwesomeIcons.music),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        top: 12,
                      ),
                      child: SwipeTo(
                        iconSize: 0,
                        onLeftSwipe: () {
                          assetAudioPlayer.next();
                        },
                        onRightSwipe: () {
                          assetAudioPlayer.previous();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myAudio.metas.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              myAudio.metas.artist!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          assetAudioPlayer.previous();
                        },
                        icon: const Icon(FontAwesomeIcons.stepBackward),
                      ),
                      PlayerBuilder.isPlaying(
                          player: assetAudioPlayer,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: () async {
                                await assetAudioPlayer.playOrPause();
                              },
                              icon: Icon(
                                isPlaying
                                    ? FontAwesomeIcons.pause
                                    : FontAwesomeIcons.play,
                              ),
                            );
                          }),
                      GestureDetector(
                        child: IconButton(
                          onPressed: () {
                            assetAudioPlayer.next();
                          },
                          icon: const Icon(FontAwesomeIcons.stepForward),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.list),
            label: 'Library',
          ),
        ],
        elevation: 0,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
