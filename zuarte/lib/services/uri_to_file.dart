import 'dart:io';

Future<File?> uriToFile(Uri? uri) async {
  if (uri == null) {
    return null;
  }
  return File.fromUri(uri);
}
