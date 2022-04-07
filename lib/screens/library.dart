// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/database/dbsongs.dart';
import 'package:music/widgets/customplaylist.dart';

import '../widgets/createplaylistdialog.dart';
import '../widgets/customlist.dart';
import '../widgets/editplaylistname.dart';
import 'favorites.dart';
import 'playlistscreen.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final box = MusicBox.getInstance();
  List playlists = [];
  String? playlistName = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Library',
            style: GoogleFonts.poppins(),
          ),
        ),
        body: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              Column(
                children: [
                  CustomListTile(
                    titleNew: 'Create Playlist',
                    leadingNew: FontAwesomeIcons.plusSquare,
                    ontapNew: () {
                      showDialog(
                        context: context,
                        builder: (context) => CreatePlaylist(),
                      );
                    },
                  ),
                  CustomListTile(
                    titleNew: 'Favourites',
                    leadingNew: FontAwesomeIcons.heart,
                    ontapNew: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, boxes, _) {
                    playlists = box.keys.toList();
                    return ListView.builder(
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: playlists[index] != "musics" &&
                                  playlists[index] != "favourites"
                              ? CustomPlayList(
                                  titleNew: playlists[index].toString(),
                                  leadingNew: Icons.queue_music,
                                  trailingNew: PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text(
                                          'Remove Playlist',
                                          style:
                                              GoogleFonts.poppins(fontSize: 15),
                                        ),
                                        value: "0",
                                      ),
                                      PopupMenuItem(
                                        value: "1",
                                        child: Text(
                                          "Rename Playlist",
                                          style:
                                              GoogleFonts.poppins(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                    onSelected: (value) {
                                      if (value == "0") {
                                        box.delete(playlists[index]);
                                        setState(() {
                                          playlists = box.keys.toList();
                                        });
                                      }
                                      if (value == "1") {
                                        showDialog(
                                          context: context,
                                          builder: (context) => EditPlaylist(
                                            playlistName: playlists[index],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  ontapNew: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlaylistScreen(
                                          playlistName: playlists[index],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
