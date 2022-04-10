// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music/database/dbsongs.dart';
import 'package:music/screens/addtoplaylist.dart';

class MusicListMenu extends StatelessWidget {
  final String songId;
  MusicListMenu({Key? key, required this.songId}) : super(key: key);

  final box = MusicBox.getInstance();
  List<LocalSongs> dbSongs = [];
  List<Audio> fullSongs = [];

  @override
  Widget build(BuildContext context) {
    dbSongs = box.get("musics") as List<LocalSongs>;
    List? favourites = box.get("favourites");
    final temp = databaseSongs(dbSongs, songId);
    return PopupMenuButton(
      itemBuilder: (BuildContext bc) => [
        favourites!
                .where((element) => element.id.toString() == temp.id.toString())
                .isEmpty
            ? PopupMenuItem(
                onTap: () async {
                  favourites.add(temp);
                  await box.put("favourites", favourites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        temp.title! + " Added to Favourites",
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Add to Favourite",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              )
            : PopupMenuItem(
                onTap: () async {
                  favourites.removeWhere(
                      (element) => element.id.toString() == temp.id.toString());
                  await box.put("favourites", favourites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        temp.title! + " Removed from Favourites",
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Remove From Favourite",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
        const PopupMenuItem(
          child: Text(
            "Add to Playlist",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          value: "1",
        ),
      ],
      onSelected: (value) async {
        if (value == "1") {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddtoPlayList(song: temp),
          );
        }
      },
    );
  }

  LocalSongs databaseSongs(List<LocalSongs> songs, String id) {
    return songs.firstWhere(
      (element) => element.id.toString().contains(id),
    );
  }
}
