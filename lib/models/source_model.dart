class SourcesModel {
  String? status;
  String? message;
  List<Sources>? sources;

  SourcesModel({this.status, this.sources});

  SourcesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // message = json['message'];
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(Sources.fromJson(v));
      });
    }
  }
}

class Sources {
  String? id;
  String? name;
  String? message;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  Sources(
      {this.id,
      this.name,
      this.message,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country});

  Sources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    message = json['message'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
  }
}
