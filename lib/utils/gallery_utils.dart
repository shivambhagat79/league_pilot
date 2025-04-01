String formatImageUrl(String url) {
  // Check if the URL is from Google Drive
  if (url.contains("drive.google.com")) {
    RegExp regExp = RegExp(r'/d/([a-zA-Z0-9_-]+)/');
    Match? match = regExp.firstMatch(url);

    if (match != null) {
      String fileId = match.group(1)!;
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    }
  }
  // Return original URL if it's not a Google Drive link
  return url;
}
