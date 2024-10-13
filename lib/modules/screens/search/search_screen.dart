// import 'package:flutter/material.dart';
// import 'package:news_app/modules/layouts/custom_Bg_widget.dart';
// import 'package:news_app/modules/screens/details_screen.dart';
// import 'package:news_app/modules/screens/search/news_item.dart';
// import 'package:provider/provider.dart';
// import 'package:news_app/modules/home/manager/home_view_model.dart';

// class Search extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           Provider.of<HomeViewModel>(context, listen: false).clearSearch();
//         },
//       )
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null); // Close search delegate
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final viewModel = Provider.of<HomeViewModel>(context);

//     if (viewModel.isSearching) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (viewModel.searchResults.isEmpty) {
//       return Center(child: const Text('No articles found.'));
//     }

//     return CustomBgWidget(
//       child: ListView.builder(
//         itemCount: viewModel.searchResults.length,
//         itemBuilder: (context, index) {
//           var article = viewModel.searchResults[index];
//           return InkWell(
//             onTap: () {
//               Navigator.of(context).pushNamed(
//                 DetailsScreen.routeName,
//                 arguments: DetailsScreen(article: article),
//               );
//             },
//             child: NewsItem(
//               index: index,
//               artical: viewModel.searchResults,
//             ),
//           );
//         },
//       ),
//     );
//   }
  
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     throw UnimplementedError();
//   }
// }
//   // @override
//   // Widget buildSuggestions(BuildContext context) {
//   //   final viewModel = Provider.of<HomeViewModel>(context);
//   //   viewModel.fetchSuggestions(query);

//   //   if (viewModel.isSearching) {
//   //     return const Center(child: CircularProgressIndicator());
//   //   }

//   //   if (viewModel.searchSuggestions.isEmpty) {
//   //     return Center(child: const Text('No suggestions available.'));
//   //   }

//   //   return ListView.builder(
//   //     itemCount: viewModel.searchSuggestions.length,
//   //     itemBuilder: (context, index) {
//   //       var article = viewModel.searchSuggestions[index];
//   //       return ListTile(
//   //         title: Text(article.title ?? 'No Title'),
//   //         onTap: () {
//   //           query = article.title ?? '';
//   //           viewModel.searchArticles(query);
//   //           showResults(context); // Show search results
//   //         },
//   //       );
//   //     },
//   //   );
//   // }



