import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer audioPlayer = AudioPlayer();

  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  void _listenForCurrentSongIndexChanges() {
    audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) {
        return;
      }
      mediaItem.add(playlist[index]);
    });
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
        ],
        systemActions: {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        playing: audioPlayer.playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }

  Future<void> initSongs(List<MediaItem> songs) async {
    audioPlayer.playbackEventStream.listen(_broadcastState);
    final audioSource = songs.map(_createAudioSource).toList();
    await audioPlayer.setAudioSources(audioSource);
    queue.value.clear();
    queue.value.addAll(songs);
    queue.add(queue.value);

    _listenForCurrentSongIndexChanges();

    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        skipToNext();
      }
    });
  }

  @override
  Future<void> play() => audioPlayer.play();

  @override
  Future<void> pause() => audioPlayer.pause();

  @override
  Future<void> skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  @override
  Future<void> skipToNext() => audioPlayer.seekToNext();

  @override
  Future<void> skipToPrevious() => audioPlayer.seekToPrevious();
}
