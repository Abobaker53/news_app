class Article {
  final String title;
  final String? author;
  final String? description;
  final String? image;
  final String url;
  final String date;

  Article({
    required this.title,
    this.author,
    this.description,
    this.image,
    required this.url,
    required this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      author: json['author'],
      description: json['description'],
      image: json['urlToImage'],
      url: json['url'] ?? '',
      date: json['publishedAt'] ?? '',
    );
  }
}