import 'package:flutter/material.dart';
import 'package:news_app/modules/home/manager/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildSearchField extends StatelessWidget {
  const BuildSearchField({
    super.key,
    required this.searchController,
    required this.context,
    required this.viewModel,
  });

  final TextEditingController searchController;
  final BuildContext context;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.search,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.white60),
        ),
        style: const TextStyle(color: Colors.white),
        onSubmitted: (query) {
          if (query.isNotEmpty) {
            viewModel.searchArticles(query);
          }
        });
  }
}
