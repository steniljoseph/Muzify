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
                            trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  value: "1",
                                  child: Text(
                                    "Remove song",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == "1") {
                                  setState(() {
                                    playlistSongs.removeAt(index);
                                    box.put(widget.playlistName, playlistSongs);
                                  });
                                }
                              },
                            ),
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
    );
  }
}
