import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/classes/openaudio.dart';
import 'package:music/database/dbsongs.dart';
import 'package:music/widgets/musiclistmenu.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'nowplaying.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<LocalSongs>? dbSongs = [];
  List<Audio> playLiked = [];
  final box = MusicBox.getInstance();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favourites',
          ),
          elevation: 0.0,
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    final likedSongs = box.get("favourites");
                    return ListView.builder(
                      itemCount: likedSongs!.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          for (var element in likedSongs) {
                            playLiked.add(
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
                          OpenPlayer(fullSongs: playLiked, index: index)
                              .openAssetPlayer(index: index, songs: playLiked);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MusicPlayerScreen(
                                fullSongs: playLiked,
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: QueryArtworkWidget(
                              id: likedSongs[index].id!,
                              type: ArtworkType.AUDIO,
                              artworkBorder: BorderRadius.circular(15),
                              artworkFit: BoxFit.cover,
                              nullArtworkWidget: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logodefault.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          trailing: MusicListMenu(
                              songId: likedSongs[index].id.toString()),
                          title: Text(
                            likedSongs[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                          subtitle: Text(
                            likedSongs[index].artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
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
