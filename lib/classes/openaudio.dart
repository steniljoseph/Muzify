import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenPlayer {
  List<Audio> fullSongs;
  int index;
  bool? notify;
  Future<bool?> setNotifyValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    notify = preferences.getBool('notification');
    return notify;
  }

  OpenPlayer({required this.fullSongs, required this.index});

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  openAssetPlayer({List<Audio>? songs, required int index}) async {
    notify = await setNotifyValue();
    player.open(
      Playlist(audios: songs, startIndex: index),
      showNotification: notify == null || notify == true ? true : false,
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      autoStart: true,
      loopMode: LoopMode.playlist,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      playInBackground: PlayInBackground.enabled,
    );
  }
}
