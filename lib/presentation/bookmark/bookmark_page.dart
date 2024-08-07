import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bookmark_view.dart';
import 'bookmark_viewmodel.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookmarkViewModel>(
        create: (_) => BookmarkViewModel(), child: BookmarkView());
  }
}
