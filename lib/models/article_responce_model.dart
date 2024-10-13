class ArticleModel {
  final String? status;
  final int? totalResults;
  final List<Articles> articles;

  ArticleModel(
      {required this.status,
      required this.totalResults,
      required this.articles});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    List<Articles> articlesList =
        list.map((i) => Articles.fromJson(i)).toList();
    return ArticleModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: articlesList,
    );
  }
}

class Articles {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Articles({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

class Source {
  final String? id;
  final String? name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}
