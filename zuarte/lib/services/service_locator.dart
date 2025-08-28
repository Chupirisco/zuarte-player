import 'package:get_it/get_it.dart';

import 'audio_handler.dart';

final getIt = GetIt.instance;

void setupLocator(SongHandler handler) {
  getIt.registerSingleton<SongHandler>(handler);
}
