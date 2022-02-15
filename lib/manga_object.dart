class Manga {
  final int seriesId;
  final String seriesTitle;
  final String seriesSlug;
  final String coverImage;
  final String synopsis;
  final List<dynamic> genre;
  final String selfUrl;
  final String chaptersUrl;
  final String sourceUrl;
  final String created_at;
  final String updated_at;

  const Manga({
    required this.seriesId,
    required this.seriesTitle,
    required this.seriesSlug,
    required this.coverImage,
    required this.synopsis,
    required this.genre,
    required this.selfUrl,
    required this.chaptersUrl,
    required this.sourceUrl,
    required this.created_at,
    required this.updated_at,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      seriesId: json['seriesId'] as int,
      seriesTitle: json['seriesTitle'] as String,
      seriesSlug: json['seriesSlug'] as String,
      coverImage: json['coverImage'] as String,
      synopsis: json['synopsis'] as String,
      genre: json['genre'] as List<dynamic>,
      selfUrl: json['selfUrl'] as String,
      chaptersUrl: json['chaptersUrl'] as String,
      sourceUrl: json['sourceUrl'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );
  }
}
