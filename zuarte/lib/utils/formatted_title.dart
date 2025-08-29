String formattedTitle(String title) {
  String cleanedTitle = title;
  // remove parentheses
  cleanedTitle = cleanedTitle.replaceAll(RegExp(r'\([^)]*\)'), '');
  //remove brackets
  cleanedTitle = cleanedTitle.replaceAll(RegExp(r'\[[^\]]*\]'), '');
  //remove file extension
  if (cleanedTitle.contains('.')) {
    cleanedTitle = cleanedTitle.split('.').first;
  }

  return cleanedTitle;
}
