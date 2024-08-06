import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bookmark/bookmark_viewmodel.dart';
import 'detail_view.dart';
import 'detail_viewmodel.dart';

class DetailPage extends StatelessWidget {
  String login;

  DetailPage({super.key, required this.login});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DetailViewModel(login)),
        ChangeNotifierProvider(create: (context) => BookmarkViewModel()),
      ],
      child: DetailView(),
    );
  }
}
