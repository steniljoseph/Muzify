import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/classes/openaudio.dart';
import 'package:music/screens/addtoplaylist.dart';
import 'package:music/screens/favorites.dart';
import 'package:music/screens/nowplaying.dart';
import 'package:music/screens/settings.dart';
import 'package:music/widgets/custommusic.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/dbsongs.dart';

class MusicList extends StatefulWidget {
  List<Audio> fullSongs = [];
  MusicList({Key? key, required this.fullSongs}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  List? dbSongs = [];
  List<dynamic>? favorites = [];
  List<dynamic>? likedSongs = [];

  final box = MusicBox.getInstance();
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  final _audioQuery = OnAudioQuery();

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    super.initState();
    dbSongs = box.get("musics");
  }

  // List<SongModel> songs = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Listen to your music',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            Wrap(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavScreen(),
                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.heart),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.cog),
                ),
              ],
            )
          ],
        ),
        // ignore: sized_box_for_whitespace
        body: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<SongModel>>(
                  future: _audioQuery.querySongs(
                    sortType: SongSortType.DISPLAY_NAME,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                  ),
                  builder: (context, item) {
                    if (item.data == null || item.data!.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      itemCount: widget.fullSongs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            widget.fullSongs[index].metas.title!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            widget.fullSongs[index].metas.artist!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                value: '0',
                                child: Text(
                                  'Add to Playlist',
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                              ),
                              likedSongs!
                                      .where((element) =>
                                          element.id.toString() ==
                                          dbSongs![index].id.toString())
                                      .isEmpty
                                  ? PopupMenuItem(
                                      child: Text(
                                        'Add to Favourites',
                                        style:
                                            GoogleFonts.poppins(fontSize: 15),
                                      ),
                                      onTap: () async {
                                        final songs = box.get("musics")
                                            as List<LocalSongs>;
                                        final temp = songs.firstWhere(
                                            (element) =>
                                                element.id.toString() ==
                                                widget.fullSongs[index].metas.id
                                                    .toString());
                                        favorites = likedSongs;
                                        favorites?.add(temp);
                                        box.put("favourites", favorites!);

                                        // Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Added to Favourites'),
                                          ),
                                        );
                                      },
                                    )
                                  : PopupMenuItem(
                                      child: Text(
                                        'Remove from Favourites',
                                        style:
                                            GoogleFonts.poppins(fontSize: 15),
                                      ),
                                      onTap: () async {
                                        likedSongs?.removeWhere((elemet) =>
                                            elemet.id.toString() ==
                                            dbSongs![index].id.toString());
                                        await box.put(
                                            "favourites", likedSongs!);
                                        setState(() {});

                                        // Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Removed From Favourites'),
                                          ),
                                        );
                                      },
                                    )
                            ],
                            onSelected: (value) {
                              if (value == '0') {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) => AddtoPlayList(
                                    song: widget.fullSongs[index],
                                  ),
                                );
                              }
                              if (value == '1') {}
                            },
                          ),
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: QueryArtworkWidget(
                              nullArtworkWidget:
                                  const Icon(FontAwesomeIcons.music),
                              id: int.parse(
                                  widget.fullSongs[index].metas.id.toString()),
                              type: ArtworkType.AUDIO,
                            ),
                          ),
                          onTap: () async {
                            await OpenPlayer(fullSongs: [], index: index)
                                .openAssetPlayer(
                                    index: index, songs: widget.fullSongs);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => MusicPlayerScreen(
                            //       index: index,
                            //       fullSongs: widget.fullSongs,
                            //     ),
                            //   ),
                            // );
                          },
                        );

                        // return ListViewMusic(
                        //   newtitile: item.data![index].displayNameWOExt,
                        //   newsubtitle: item.data![index].artist.toString(),
                        //   newimage: QueryArtworkWidget(
                        //     nullArtworkWidget:
                        //         Image.asset('assets/images/tujmein.jpg'),
                        //     id: item.data![index].id,
                        //     type: ArtworkType.AUDIO,
                        //   ),
                        //   ontapNew: () {},
                        // );
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
