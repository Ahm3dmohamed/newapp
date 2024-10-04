// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:news_app/manager/api_manager.dart';
// import 'package:news_app/models/article_responce_model.dart';

// class SearchScreen extends StatefulWidget {
//   SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   List<Articles>? searchResults;
//   bool isSearching = false;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: isSearching
//                 ? const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : searchResults == null
//                     ? const Center(
//                         child: Text("Search For Data Broo"),
//                       )
//                     : ListView.builder(
//                         itemCount: searchResults?.length,
//                         itemBuilder: (context, index) {
//                           Articles article = searchResults![index];
//                           return _BuildArticleWidgetData(size, article);
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _BuildArticleWidgetData(Size size, Articles article) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Article Image
//             if (article.urlToImage != null)
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                 ),
//                 child: CachedNetworkImage(
//                   height: size.height * 0.25,
//                   width: size.width,
//                   fit: BoxFit.cover,
//                   imageUrl: article.urlToImage!,
//                   placeholder: (context, url) =>
//                       const Center(child: CircularProgressIndicator()),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     article.title ?? "No Title",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     article.description ?? "No Description available",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                   const SizedBox(height: 8),
//                   // Published Time
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         article.publishedAt?.substring(0, 10) ?? "Unknown Date",
//                         style:
//                             const TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       const Icon(Icons.more_vert),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
