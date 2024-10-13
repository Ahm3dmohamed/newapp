import 'package:flutter/material.dart';
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/modules/screens/details_screen.dart';

class ArticleCardWidget extends StatelessWidget {
  final Articles article;
  final String? title;
  final String? description;

  const ArticleCardWidget({
    super.key,
    required this.article,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(article: article),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handling null for article.urlToImage
              if (article.urlToImage != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    article.urlToImage!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                const SizedBox(
                  height: 200,
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handling null for article.title
                    Text(
                      article.title ?? "No Title",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Handling null for article.publishedAt
                        Text(
                          article.publishedAt?.substring(0, 10) ??
                              "Unknown Date",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
