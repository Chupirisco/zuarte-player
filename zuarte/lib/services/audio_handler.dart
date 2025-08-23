import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class ZuarteAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  ZuarteAudioHandler() {
    // Atualiza o estado da reprodução
    _player.playbackEventStream.listen((event) {
      playbackState.add(
        playbackState.value.copyWith(
          controls: [MediaControl.play, MediaControl.pause, MediaControl.stop],
          playing: _player.playing,
          processingState: {
            ProcessingState.idle: AudioProcessingState.idle,
            ProcessingState.loading: AudioProcessingState.loading,
            ProcessingState.buffering: AudioProcessingState.buffering,
            ProcessingState.ready: AudioProcessingState.ready,
            ProcessingState.completed: AudioProcessingState.completed,
          }[_player.processingState]!,
        ),
      );
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  Future<void> setAudioSource(String url) async {
    await _player.setUrl(url);
  }
}
