import 'package:flutter/material.dart';
import 'package:github_app/presentation/search/search_view.dart';
import 'package:github_app/presentation/search/search_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
        create: (_) => SearchViewModel(), child: SearchView());
  }
}
