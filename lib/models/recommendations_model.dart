class RecommendationItem {
  final String title;
  final String? author;
  final String? buttonLabel;

  RecommendationItem({
    required this.title,
    this.author,
    this.buttonLabel
  });

  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'author': author,
      'buttonLabel': buttonLabel,
    };
  }

  factory RecommendationItem.fromJson(Map<String, dynamic> json) {
    return RecommendationItem(
      title: json['title'],
      author: json['author'],
      buttonLabel: json['buttonLabel'],
    );
}

}
