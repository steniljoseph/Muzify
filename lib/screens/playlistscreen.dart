// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/database/dbsongs.dart';
import 'package:music/screens/nowplaying.dart';
import 'package:music/widgets/songsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../classes/openaudio.dart';

class PlaylistScreen extends StatefulWidget {
  String playlistName;

  PlaylistScreen({
    Key? key,
    required this.playlistName,
  }) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  // final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");
  // final audioQuery = OnAudioQuery();
  final box = MusicBox.getInstance();
  List<LocalSongs>? dbSongs = [];
  List<LocalSongs>? playlistSongs = [];
  List<Audio> playPlaylist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.playlistName,
          style: GoogleFonts.poppins(),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return SongSheet(
                      playlistName: widget.playlistName,
                    );
                  },
                );
              },
              icon: const Icon(FontAwesomeIcons.plus),
            ),
          )
        ],
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                var playlistSongs = box.get(widget.playlistName)!;
                return playlistSongs.isEmpty
                    ? SizedBox(
                        child: Center(
                          child: Text(
                            "Add Some Songs!",
                            style: GoogleFonts.poppins(fontSize: 25),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: playlistSongs.length,
                        itemBuilder: (context, index) => GestureDetector(
                          child: ListTile(
                            leading: QueryArtworkWidget(
                              id: playlistSongs[index].id!,
                              type: ArtworkType.AUDIO,
                              artworkBorder: BorderRadius.circular(15),
                              artworkFit: BoxFit.cover,
                              nullArtworkWidget: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      15,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logodefault.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              playlistSongs[index].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(),
                            ),
                            subtitle: Text(playlistSongs[index].artist!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins()),
                            // trailing: PopupMenuButton(
                            //   itemBuilder: (BuildContext context) => [
                            //     PopupMenuItem(
                            //       value: "1",
                            //       child: Text(
                            //         "Remove song",
                            //         style: GoogleFonts.poppins(),
                            //       ),
                            //     ),
                            //   ],
                            //   onSelected: (value) {
                            //     if (value == "1") {
                            //       setState(() {});
                            //       // playlistSongs.removeAt(index);
                            //     }
                            //   },
                            //   // icon: const Icon(
                            //   //   Icons.more_horiz,
                            //   //   color: Colors.white,
                            //   // ),
                            // ),
                            // onTap: () {
                            //   for (var element in playlistSongs) {
                            //     playPlaylist.add(
                            //       Audio.file(
                            //         element.uri!,
                            //         metas: Metas(
                            //           title: element.title,
                            //           id: element.id.toString(),
                            //           artist: element.artist,
                            //         ),
                            //       ),
                            //     );
                            //   }
                            //   OpenPlayer(fullSongs: playPlaylist, index: index)
                            //       .openAssetPlayer(
                            //           index: index, songs: playPlaylist);
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => MusicPlayerScreen(
                            //         fullSongs: playPlaylist,
                            //         index: index,
                            //       ),
                            //     ),
                            //   );
                            // },
                          ),
                          onTap: () {
                            for (var element in playlistSongs) {
                              playPlaylist.add(
                                Audio.file(
                                  element.uri!,
                                  metas: Metas(
                                    title: element.title,
                                    id: element.id.toString(),
                                    artist: element.artist,
                                  ),
                                ),
                              );
                            }
                            OpenPlayer(fullSongs: playPlaylist, index: index)
                                .openAssetPlayer(
                                    index: index, songs: playPlaylist);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MusicPlayerScreen(
                                  fullSongs: playPlaylist,
                                  index: index,
                                ),
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          )
        ],
      ),
      // bottomSheet: GestureDetector(
      //   onTap: (() {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => MusicPlayerScreen(
      //           index: 0,
      //           fullSongs: widget.allSong,
      //         ),
      //       ),
      //     );
      //   }),
      //   child: SizedBox(
      //     height: 60,
      //     child: assetAudioPlayer.builderCurrent(
      //       builder: (BuildContext context, Playing? playing) {
      //         final myAudio =
      //             find(widget.allSong, playing!.audio.assetAudioPath);
      //         return Row(
      //           children: [
      //             const SizedBox(
      //               width: 10,
      //             ),
      //             SizedBox(
      //               height: 50,
      //               width: 50,
      //               child: CircleAvatar(
      //                 child: QueryArtworkWidget(
      //                     id: int.parse(myAudio.metas.id!),
      //                     type: ArtworkType.AUDIO,
      //                     artworkBorder:
      //                         const BorderRadius.all(Radius.circular(28)),
      //                     artworkFit: BoxFit.cover,
      //                     nullArtworkWidget:
      //                         const Icon(FontAwesomeIcons.music)),
      //               ),
      //             ),
      //             Expanded(
      //               child: Padding(
      //                 padding: const EdgeInsets.only(
      //                   left: 12,
      //                   top: 12,
      //                 ),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       myAudio.metas.title!,
      //                       maxLines: 1,
      //                       overflow: TextOverflow.ellipsis,
      //                       style: GoogleFonts.poppins(
      //                           fontWeight: FontWeight.w500),
      //                     ),
      //                     const SizedBox(height: 4),
      //                     Text(
      //                       myAudio.metas.artist!,
      //                       maxLines: 1,
      //                       overflow: TextOverflow.ellipsis,
      //                       style: GoogleFonts.poppins(fontSize: 12),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 IconButton(
      //                   onPressed: () {
      //                     assetAudioPlayer.previous();
      //                   },
      //                   icon: const Icon(FontAwesomeIcons.stepBackward),
      //                 ),
      //                 const SizedBox(width: 10),
      //                 PlayerBuilder.isPlaying(
      //                     player: assetAudioPlayer,
      //                     builder: (context, isPlaying) {
      //                       return IconButton(
      //                         onPressed: () async {
      //                           await assetAudioPlayer.playOrPause();
      //                         },
      //                         icon: Icon(
      //                           isPlaying
      //                               ? FontAwesomeIcons.pause
      //                               : FontAwesomeIcons.play,
      //                           size: 30,
      //                         ),
      //                       );
      //                     }),
      //                 const SizedBox(width: 10),
      //                 IconButton(
      //                   onPressed: () {
      //                     assetAudioPlayer.next();
      //                   },
      //                   icon: const Icon(FontAwesomeIcons.stepForward),
      //                 ),
      //                 const SizedBox(width: 15),
      //               ],
      //             )
      //           ],
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
