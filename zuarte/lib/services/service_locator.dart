import 'package:get_it/get_it.dart';
import 'audio_handler.dart';
import 'package:audio_service/audio_service.dart';

final getIt = GetIt.instance;

Future<void> initAudioService() async {
  final audioHandler = await AudioService.init(
    builder: () => ZuarteAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.zuarte.channel.audio',
      androidNotificationChannelName: 'Zuarte Audio',
      androidNotificationOngoing: true,
    ),
  );

  getIt.registerSingleton<AudioHandler>(audioHandler);
}
