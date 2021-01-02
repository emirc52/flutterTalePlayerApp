import 'package:tales/model/tale.dart';
import 'package:tales/services/local_player_services.dart';
import 'package:tales/services/local_tale_services.dart';
import 'package:tales/utils/locator.dart';

class PlayerRepository {
  LocalPlayerServices _localPlayerServices = getIt<LocalPlayerServices>();
  LocalTaleServices _localTaleServices = getIt<LocalTaleServices>();

  //////////////////////////////////////////////////////////////////////

  Future<bool> playTale(Tale tale) async {
    return await _localPlayerServices.playTale(tale);
  }

  Future<Duration> pauseTale() async {
    return await _localPlayerServices.pauseTale();
  }

  Stream<Duration> getDuration() {
    return _localPlayerServices.getDuration();
  }

  Future<void> seekTale(Duration to) async {
    await _localPlayerServices.seekTale(to);
  }

  List<Tale> getAllTales() {
    return _localTaleServices.getAllTales();
  }
}
