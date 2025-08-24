import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();

Future<void> requestSonsPermission() async {
  try {
    final bool audioGranted = await Permission.audio.isGranted;
    final bool storageGranted = await Permission.storage.isGranted;
    bool permission = await _audioQuery.permissionsStatus();

    if (!audioGranted || !storageGranted) {
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.audio,
        Permission.storage,
      ].request();

      if (statuses[Permission.audio] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.storage] == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    }
    if (!permission) {
      _audioQuery.permissionsRequest();
    }
  } catch (e) {
    debugPrint('error requenst song permission');
  }
}
