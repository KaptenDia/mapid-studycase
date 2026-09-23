class YoutubeHelper {
  static bool isYoutubeLink(String url) {
    final regex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+',
      caseSensitive: false,
    );
    return regex.hasMatch(url);
  }

  static String getVideoId(String url) {
    final uri = Uri.parse(url);
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    } else if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'] ?? 'yt-video-id-not-found';
    }
    return 'yt-video-id-not-found';
  }

  static String getThumbnail(String url) {
    final videoId = getVideoId(url);
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }
}
