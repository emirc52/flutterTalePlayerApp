import 'package:flutter/material.dart';
import 'package:tales/model/tale.dart';
import 'package:tales/repository/player_repository.dart';
import 'package:tales/utils/locator.dart';

enum TaleState { BUSY, IDLE }

class TaleModelView with ChangeNotifier {
  PlayerRepository _playerRepository = getIt<PlayerRepository>();

  TaleState _taleState = TaleState.IDLE;

  get taleStateGet => _taleState;

  set taleStateSet(TaleState taleState) {
    _taleState = taleState;
    notifyListeners();
  }

  List<Tale> getAllTales() {
    return _playerRepository.getAllTales();
  }

  List<Tale> searchTaleWithName(String text) {
    List<Tale> foundTalesList = [];
    if (text.length > 0) {
      for (Tale tale in getAllTales()) {
        if (tale.taleName.toLowerCase().contains(text.toLowerCase())) {
          foundTalesList.add(tale);
        }
      }
    }
    taleStateSet = TaleState.IDLE;
    return foundTalesList;
  }
}
