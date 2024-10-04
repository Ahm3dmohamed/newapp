// import 'package:flutter/material.dart';
// import 'package:news_app/manager/api_manager.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:news_app/models/article_responce_model.dart';
// import 'package:news_app/models/sourses_responce_model.dart';

// class ArticleDataScreen extends StatefulWidget {
//   const ArticleDataScreen({super.key});

//   @override
//   State<ArticleDataScreen> createState() => _ArticleDataScreenState();
// }

// class _ArticleDataScreenState extends State<ArticleDataScreen> {
//   Sources? sources;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     int currentIndex = 0;

//     return FutureBuilder<ArticleModel?>(
//       future: ApiManager.getArticles(sources!.id ?? "", "es"),
//       builder: (BuildContext context, AsyncSnapshot<ArticleModel?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return const Center(child: Text("Error in Data"));
//         } else if (!snapshot.hasData || snapshot.data!.articles == null) {
//           return const Center(child: Text("No articles available"));
//         } else {
//           List<Articles> articles = snapshot.data!.articles!;

//           return ListView.builder(
//             itemCount: articles.length,
//             itemBuilder: (context, index) {
//               Articles article = articles[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Article Image
//                       if (article.urlToImage != null)
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(15),
//                             topRight: Radius.circular(15),
//                           ),
//                           child: CachedNetworkImage(
//                             height: size.height * 0.25,
//                             width: size.width,
//                             fit: BoxFit.cover,
//                             imageUrl: article.urlToImage!,
//                             placeholder: (context, url) => const Center(
//                                 child: CircularProgressIndicator()),
//                             errorWidget: (context, url, error) =>
//                                 const Icon(Icons.error),
//                           ),
//                         ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               article.title ?? "No Title",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               article.description ?? "No Description available",
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                             const SizedBox(height: 8),
//                             // Published Time
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   article.publishedAt ?? "Unknown Date",
//                                   style: const TextStyle(
//                                       fontSize: 12, color: Colors.grey),
//                                 ),
//                                 const Icon(Icons.more_vert),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
