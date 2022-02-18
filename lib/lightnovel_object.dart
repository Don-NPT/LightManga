class LightNovel {
  final String title;
  final String img;
  final String url;

  const LightNovel({
    required this.title,
    required this.img,
    required this.url,
  });

  factory LightNovel.fromJson(Map<String, dynamic> json) {
    return LightNovel(
      title: json['title'] as String,
      img: json['img'] as String,
      url: json['url'] as String,
    );
  }
}
