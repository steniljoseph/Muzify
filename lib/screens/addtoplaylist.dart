// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/database/dbsongs.dart';

import '../widgets/createplaylistdialog.dart';

class AddtoPlayList extends StatelessWidget {
  AddtoPlayList({Key? key, required this.song}) : super(key: key);
  Audio song;

  List playlists = [];
  String? playlistName = '';
  List<dynamic>? playlistSongs = [];

  @override
  Widget build(BuildContext context) {
    final box = MusicBox.getInstance();
    playlists = box.keys.toList();
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (context) => CreatePlaylist(),
              ),
              leading: const Icon(FontAwesomeIcons.plus),
              title: Text(
                "Add a New Playlist",
                style: GoogleFonts.poppins(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          ...playlists
              .map(
                (audio) => audio != "musics" && audio != 'favourites'
                    ? ListTile(
                        onTap: () async {
                          playlistSongs = box.get(audio);
                          List existingSongs = [];
                          existingSongs = playlistSongs!
                              .where((element) =>
                                  element.id.toString() ==
                                  song.metas.id.toString())
                              .toList();
                          if (existingSongs.isEmpty) {
                            final songs = box.get("musics") as List<LocalSongs>;
                            final temp = songs.firstWhere((element) =>
                                element.id.toString() ==
                                song.metas.id.toString());
                            playlistSongs?.add(temp);

                            await box.put(audio, playlistSongs!);

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Song Added',
                                style: GoogleFonts.poppins(),
                              ),
                            ));
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Existing Song',
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            );
                          }
                        },
                        leading: const Icon(Icons.queue_music),
                        title: Text(
                          audio.toString(),
                          style: GoogleFonts.poppins(fontSize: 22),
                        ),
                      )
                    : Container(),
              )
              .toList()
        ],
      ),
    );
  }
}
