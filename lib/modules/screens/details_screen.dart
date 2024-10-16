import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/models/article_responce_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = "DetailsScreen";
  final Articles article;

  const DetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title!.substring(0, 20) ??
              localizations?.no_Title ??
              "Article Details",
          style: const TextStyle(fontSize: 16),
          maxLines: 2,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: CachedNetworkImage(
                  height: size.height * 0.25,
                  width: size.width,
                  fit: BoxFit.cover,
                  imageUrl: article.urlToImage!,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/me.jpg",
                  ),
                ),
              ),
            SizedBox(height: size.height * .02),
            Text(
              article.title ?? localizations?.no_Title ?? "No Title",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: size.height * .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  article.publishedAt?.substring(0, 10) ??
                      localizations?.un_knownDate ??
                      "Unknown Date",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * .02),
            Text(
              article.content ??
                  localizations?.no_Description ??
                  "No Content Available",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: size.height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _launchUrl(article.url ?? "");
                  },
                  child: Text(
                      localizations?.view_Full_Article ?? "View Full Article"),
                ),
                const Icon(Icons.navigate_next),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    var url0 = Uri.parse(url);
    if (!await launchUrl(url0, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url0');
    }
  }
}
