import 'dart:io';

File? uriToFile(Uri? uri) {
  if (uri == null) {
    return null;
  }
  return File.fromUri(uri);
}
