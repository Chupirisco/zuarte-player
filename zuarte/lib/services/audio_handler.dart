import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer audioPlayer = AudioPlayer();

  /// Cria a fonte de áudio a partir de um MediaItem
  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  /// Observa mudanças do índice atual e atualiza o mediaItem
  void _listenForCurrentSongIndexChanges() {
    audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      mediaItem.add(playlist[index]);
    });
  }

  /// Transforma eventos de reprodução em playbackState
  void _broadcastState(PlaybackEvent event) {
    final controls = [
      MediaControl.rewind,
      MediaControl.skipToPrevious,
      if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
      MediaControl.skipToNext,
    ];

    playbackState.add(
      playbackState.value.copyWith(
        controls: controls,
        systemActions: {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 2, 4],
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

  /// Inicializa o handler
  Future<void> init() async {
    audioPlayer.playbackEventStream.listen(_broadcastState);
    _listenForCurrentSongIndexChanges();

    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        skipToNext();
      }
    });
  }

  /// Atualiza a playlist atual e opcionalmente começa de um índice específico
  Future<void> setPlaylist(
    List<MediaItem> novaPlaylist, {
    int startIndex = 0,
  }) async {
    // Atualiza o queue
    queue.value = List.from(novaPlaylist);
    queue.add(queue.value);

    // Atualiza o AudioPlayer
    final audioSources = novaPlaylist.map(_createAudioSource).toList();
    await audioPlayer.setAudioSources(audioSources);

    // Toca a partir do índice desejado
    await skipToQueueItem(startIndex);
  }

  Future<void> ensureQueue(List<MediaItem> songs) async {
    bool isDifferent =
        queue.value.length != songs.length ||
        !List.generate(
          queue.value.length,
          (index) => queue.value[index].id,
        ).asMap().entries.every((entry) => entry.value == songs[entry.key].id);

    if (queue.value.isEmpty || isDifferent) {
      queue.value = List.from(songs);
      queue.add(queue.value);

      final audioSources = songs.map(_createAudioSource).toList();
      await audioPlayer.setAudioSources(audioSources);
    }
  }

  @override
  Future<void> play() => audioPlayer.play();

  @override
  Future<void> pause() => audioPlayer.pause();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (queue.value.isEmpty) return; // evita erro se a fila estiver vazia
    if (index < 0 || index >= queue.value.length) return;

    try {
      await audioPlayer.seek(Duration.zero, index: index);
      play();
    } catch (e) {
      print('Erro ao tentar tocar música no índice $index: $e');
    }
  }

  @override
  Future<void> skipToPrevious() async {
    await audioPlayer.seekToPrevious();
    play();
  }

  @override
  Future<void> skipToNext() async {
    await audioPlayer.seekToNext();
    play();
  }

  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  @override
  Future<void> rewind() async {
    await audioPlayer.seek(Duration.zero);
  }
}
