import 'package:flutter/material.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class BuildSearchField extends StatelessWidget {
//   const BuildSearchField({
//     super.key,
//     required this.searchController,
//     required this.context,
//     required this.cubit,
//   });

//   final TextEditingController searchController;
//   final BuildContext context;
//   final HomeCubit cubit;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//         controller: searchController,
//         autofocus: true,
//         decoration: InputDecoration(
//           hintText: AppLocalizations.of(context)!.search,
//           border: InputBorder.none,
//           hintStyle: const TextStyle(color: Colors.white60),
//         ),
//         style: const TextStyle(color: Colors.white),
//         onSubmitted: (query) {
//           if (query.isNotEmpty) {
//             cubit.searchArticles(query);
//           }
//         });
//   }
// }

class CustomSearchField extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  CustomSearchField({required this.searchController, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onSearch,
      decoration: const InputDecoration(
        hintText: 'Search articles...',
        border: InputBorder.none,
      ),
    );
  }
}
