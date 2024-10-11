class RecommendationItem {
  final String title;
  final String? author;
  final String? buttonLabel;
  final String? link;

  RecommendationItem({
    required this.title,
    this.author,
    this.buttonLabel,
    this.link,
  });

  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'author': author,
      'buttonLabel': buttonLabel,
      'link': link,
    };
  }

  factory RecommendationItem.fromJson(Map<String, dynamic> json) {
    return RecommendationItem(
      title: json['title'],
      author: json['author'],
      buttonLabel: json['buttonLabel'],
      link: json['link'],
    );
}

}
