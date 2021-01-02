import 'package:get_it/get_it.dart';
import 'package:tales/repository/player_repository.dart';
import 'package:tales/services/local_player_services.dart';
import 'package:tales/services/local_tale_services.dart';

GetIt getIt = GetIt.asNewInstance();

void setup() {
  getIt.registerLazySingleton(() => LocalPlayerServices());
  getIt.registerLazySingleton(() => LocalTaleServices());

  getIt.registerLazySingleton(() => PlayerRepository());
}
