import 'package:flutter/cupertino.dart';
import 'package:tales/model/tale.dart';
import 'package:tales/repository/player_repository.dart';
import 'package:tales/utils/locator.dart';

enum PlayerState { IDLE, PLAYING, PAUSED }

class PlayerModelView with ChangeNotifier {
  PlayerRepository _playerRepository = getIt<PlayerRepository>();

  PlayerState _playerState = PlayerState.IDLE;
  Tale currentTale;
  Duration lastDuration = Duration.zero;

  get playerStateGet => _playerState;

  set playerStateSet(PlayerState playerState) {
    _playerState = playerState;
    notifyListeners();
  }

  Future<bool> playTale(Tale tale) async {
    bool isPlay = await _playerRepository.playTale(tale);
    if (isPlay == true) {
      lastDuration = Duration.zero;
      playerStateSet = PlayerState.PLAYING;
      currentTale = tale;
    }
    return isPlay;
  }

  Future<Duration> pauseTale() async {
    Duration _lastDuration = await _playerRepository.pauseTale();
    lastDuration = _lastDuration;
    playerStateSet = PlayerState.PAUSED;
    return _lastDuration;
  }

  Future<dynamic> playOrPauseSound(Tale tale) async {
    if (playerStateGet == PlayerState.PLAYING &&
        (currentTale == null || currentTale.taleID == tale.taleID)) {
      await pauseTale();
    } else {
      playTale(tale);
    }
  }

  Stream<Duration> getDuration() {
    return _playerRepository.getDuration();
  }

  Future<void> seekTale(Duration to) async {
    await _playerRepository.seekTale(to);
  }

  Duration setLastDuration(Tale taleOfThePage) {
    if ((playerStateGet == PlayerState.PAUSED) &&
        (currentTale.taleID == taleOfThePage.taleID)) {
      return lastDuration;
    } else if (!isThisPlay(taleOfThePage)) {
      return Duration.zero;
    } else
      return null;
  }

  bool isThisPlay(Tale taleOfThePage) {
    return playerStateGet == PlayerState.PLAYING &&
        (currentTale == null || currentTale.taleID == taleOfThePage.taleID);
  }

  getNextTale(int taleID) {
    List<Tale> allTales = _playerRepository.getAllTales();
    Tale tale = allTales[(taleID + 1) % allTales.length];
    playTale(tale);
    return tale;
  }

  getPreviousTale(int taleID) {
    List<Tale> allTales = _playerRepository.getAllTales();
    Tale tale = allTales[(taleID - 1) % allTales.length];
    playTale(tale);
    return tale;
  }
}
