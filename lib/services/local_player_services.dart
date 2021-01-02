import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:tales/model/tale.dart';

class LocalPlayerServices {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  Audio currentAudio;
  Future<bool> playTale(Tale tale) async {
    try {
      if (currentAudio == null ||
          currentAudio.metas.album != tale.taleID.toString()) {
        assetsAudioPlayer.stop();
        _setAudio(tale);
        await _openAudio();
      }
      await assetsAudioPlayer.play();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<Duration> getDuration() {
    return assetsAudioPlayer.currentPosition;
  }

  Future<Duration> pauseTale() async {
    Duration duration = assetsAudioPlayer.currentPosition.value;
    await assetsAudioPlayer.pause();
    return duration;
  }

  Future<void> seekTale(Duration to) async {
    await assetsAudioPlayer.seek(to);
  }

  void _setAudio(tale) => currentAudio = Audio(tale.taleUrl,
      metas: Metas(
        title: tale.taleName,
        artist: tale.voicingName,
        album: tale.taleID.toString(),
        image: MetasImage.asset(tale.taleProfileUrl),
      ));

  Future<void> _openAudio() async => await assetsAudioPlayer.open(
        currentAudio,
        showNotification: true,
      );
}
