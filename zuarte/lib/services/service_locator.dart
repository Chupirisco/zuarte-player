import 'package:get_it/get_it.dart';

import 'audio_handler.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<SongHandler>(() => SongHandler());
}
