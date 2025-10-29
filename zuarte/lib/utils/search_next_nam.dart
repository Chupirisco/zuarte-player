import '../viewmodels/playlist_provider.dart';

int searchNextName(PlaylistProvider playlistProvider) {
  // Extrai todos os números já usados
  final numerosUsados = playlistProvider.playlists.map((pl) {
    final match = RegExp(r'Playlist N° (\d+)').firstMatch(pl.nome);
    return match != null ? int.parse(match.group(1)!) : 0;
  }).toSet();

  // Encontra o menor número disponível
  final numPlay = Iterable<int>.generate(numerosUsados.length + 1, (i) => i + 1)
      .firstWhere(
        (n) => !numerosUsados.contains(n),
        orElse: () => numerosUsados.length + 1,
      );

  return numPlay;
}
