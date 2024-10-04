import 'package:flutter/material.dart';
import 'package:news_app/models/article_responce_model.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Articles article = Articles();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "No Title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description ?? "No Description available",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.publishedAt ?? "Unknown Date",
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
    );
  }
}
