// ignore_for_file: sized_box_for_whitespace

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/database/dbsongs.dart';
import 'package:music/screens/addtoplaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:marquee/marquee.dart';

// ignore: must_be_immutable
class MusicPlayerScreen extends StatefulWidget {
  int index;
  List<Audio> fullSongs = [];
  MusicPlayerScreen({Key? key, required this.index, required this.fullSongs})
      : super(key: key);

  @override
  MusicPlayerScreenState createState() => MusicPlayerScreenState();
}

class MusicPlayerScreenState extends State<MusicPlayerScreen> {
  double minimumValue = 0, maximumValue = 0, currentValue = 0;
  String currentTime = '', endTime = '';

  bool isPlaying = false;
  bool _fav = false;
  LocalSongs? music;

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  late TextEditingController controller;
  final box = MusicBox.getInstance();
  List<LocalSongs> dbSongs = [];

  @override
  void initState() {
    super.initState();
    dbSongs = box.get("musics") as List<LocalSongs>;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(FontAwesomeIcons.chevronDown),
          ),
          title: Text(
            'Now Playing',
            style: GoogleFonts.poppins(),
          ),
          centerTitle: true,
          // actions: [
          //   PopupMenuButton(
          //     itemBuilder: (context) => [
          //       PopupMenuItem(
          //         value: '0',
          //         child: Text(
          //           'Add to Playlist',
          //           style: GoogleFonts.poppins(fontSize: 15),
          //         ),
          //       ),
          //       PopupMenuItem(
          //         onTap: (() {}),
          //         child: Text(
          //           'Add to Favourites',
          //           style: GoogleFonts.poppins(fontSize: 15),
          //         ),
          //       ),
          //     ],
          //     // onSelected: (value) {
          //     //   if (value == '0') {
          //     //     showModalBottomSheet(
          //     //       shape: const RoundedRectangleBorder(
          //     //         borderRadius: BorderRadius.vertical(
          //     //           top: Radius.circular(20),
          //     //         ),
          //     //       ),
          //     //       context: context,
          //     //       builder: (context) => AddtoPlayList(
          //     //         song: widget.fullSongs.,
          //     //       ),
          //     //     );
          //     //   }
          //     // },
          //   ),
          // ],
        ),
        body: player.builderCurrent(
          builder: (context, Playing? playing) {
            final myAudio =
                find(widget.fullSongs, playing!.audio.assetAudioPath);

            // final currentSong = dbSongs.firstWhere((element) =>
            //     element.id.toString() == myAudio.metas.id.toString());
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(20, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: QueryArtworkWidget(
                          artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                          artworkFit: BoxFit.fill,
                          nullArtworkWidget:
                              Image.asset('assets/images/logodefault.jpg'),
                          id: int.parse(myAudio.metas.id!),
                          type: ArtworkType.AUDIO,
                        ),

                        // Image(
                        //   image: const AssetImage('assets/images/parudeesa.jpg'),
                        //   width: MediaQuery.of(context).size.width * 0.7,
                        //   height: MediaQuery.of(context).size.width * 0.7,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  ),

                  // buildAnimatedText(myAudio.metas.title!),

                  Text(
                    myAudio.metas.title!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 25),
                  ),

                  Text(
                    myAudio.metas.artist!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: seekBar(context),
                    // Row(
                    //   children: [
                    //     // Expanded(
                    //     //   child: player.builderRealtimePlayingInfos(
                    //     //     builder: (context, RealtimePlayingInfos? infos) {
                    //     //       if (infos == null) {
                    //     //         return const SizedBox();
                    //     //       }
                    //     //       return ProgressBar(
                    //     //         timeLabelPadding: 8,
                    //     //         progressBarColor: Colors.white,
                    //     //         thumbColor: Colors.white,
                    //     //         baseBarColor: Colors.grey,
                    //     //         progress: infos.currentPosition,
                    //     //         total: Duration(
                    //     //             milliseconds: currentsong!.duration!),
                    //     //         timeLabelTextStyle:
                    //     //             const TextStyle(color: Colors.white),
                    //     //         onSeek: (duration) {
                    //     //           player.seek(duration);
                    //     //         },
                    //     //       );
                    //     //     },
                    //     //   ),
                    //     //   //   child: StreamBuilder<Duration>(
                    //     //   //     stream: player.currentPosition,
                    //     //   //     builder: (context, snapshot) {
                    //     //   //       return Slider(
                    //     //   //         max: playing.audio.duration.inMilliseconds
                    //     //   //             .toDouble(),
                    //     //   //         value: snapshot.data == null
                    //     //   //             ? 0
                    //     //   //             : snapshot.data!.inMilliseconds.toDouble(),
                    //     //   //         onChanged: (value) {
                    //     //   //           player.seek(
                    //     //   //             Duration(
                    //     //   //               milliseconds: value.round(),
                    //     //   //             ),
                    //     //   //           );
                    //     //   //         },
                    //     //   //       );
                    //     //   //     },
                    //     //   //   ),
                    //     // ),

                    //     // Text(
                    //     //   endTime,
                    //     //   style: GoogleFonts.poppins(fontSize: 18),
                    //     // ),
                    //   ],
                    // ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shuffle),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(
                            () {
                              _fav = !_fav;
                            },
                          );
                        },
                        icon:
                            Icon(_fav ? Icons.favorite : Icons.favorite_border),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.repeat),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          player.previous();
                        },
                        icon: const Icon(FontAwesomeIcons.stepBackward),
                      ),
                      PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isPlaying) {
                          return IconButton(
                            iconSize: 50,
                            onPressed: () async {
                              await player.playOrPause();
                            },
                            icon: Icon(
                              isPlaying
                                  ? FontAwesomeIcons.pause
                                  : FontAwesomeIcons.play,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          player.next();
                        },
                        icon: const Icon(FontAwesomeIcons.stepForward),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget seekBar(BuildContext ctx) {
    return player.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration currentPos = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ProgressBar(
            progress: currentPos,
            total: total,
            // progressBarColor: Colors.white,
            baseBarColor: Colors.grey,
            // thumbColor: Colors.white,
            timeLabelTextStyle: GoogleFonts.poppins(
              color: Colors.grey,
            ),
            onSeek: (to) {
              player.seek(to);
            },
          ),
        );
      },
    );
  }

  Widget buildAnimatedText(String text) => Marquee(
        text: text,
        style: GoogleFonts.poppins(fontSize: 25),
      );
}
