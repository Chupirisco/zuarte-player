String formattedTitle(String title) {
  String cleanedTitle = title;
  // remover parenteses
  cleanedTitle = cleanedTitle.replaceAll(RegExp(r'\([^)]*\)'), '');
  //remover colchetes
  cleanedTitle = cleanedTitle.replaceAll(RegExp(r'\[[^\]]*\]'), '');
  //remover extenção de arquivo
  if (cleanedTitle.contains('.')) {
    cleanedTitle = cleanedTitle.split('.').first;
  }

  return cleanedTitle;
}
