// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music/classes/openaudio.dart';
import 'package:music/screens/favorites.dart';
import 'package:music/screens/settings.dart';
import 'package:music/widgets/musiclistmenu.dart';
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Listen to your music',
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
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),
                          subtitle: Text(
                            widget.fullSongs[index].metas.artist!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, fontFamily: 'Poppins'),
                          ),
                          trailing: MusicListMenu(
                            songId: widget.fullSongs[index].metas.id.toString(),
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
                              index: index,
                              songs: widget.fullSongs,
                            );
                          },
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
