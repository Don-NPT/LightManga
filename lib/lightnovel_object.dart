class LightNovel {
  final String title;
  final String img;
  final String link;

  const LightNovel({
    required this.title,
    required this.img,
    required this.link,
  });

  factory LightNovel.fromJson(Map<String, dynamic> json) {
    return LightNovel(
      title: json['title'] as String,
      img: json['img'] as String,
      link: json['link'] as String,
    );
  }
}
