import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dto/user_info.dart';
import '../detail/detail_page.dart';
import 'bookmark_viewmodel.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  BookmarkViewState createState() => BookmarkViewState();
}

class BookmarkViewState extends State<BookmarkView> {
  late BookmarkViewModel viewModel;

  Future<void> _onClickCard(BuildContext context, UserInfo item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(login: item.login),
      ),
    );

    if (result == false) {
      setState(() {
        viewModel.deleteBookmark(item.login);
      });
    }
  }

  void _deleteBookmark(String login) {
    setState(() {
      viewModel.deleteBookmark(login);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<BookmarkViewModel>(context);

    return Scaffold(
      body: _bookmarkList(),
    );
  }

  Widget _bookmarkList() {
    final state = viewModel.state;

    if (state.isLoaded == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (state.items.isEmpty) {
        return _bookmarkEmptyView();
      } else {
        return Expanded(
          child: ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (BuildContext context, int index) {
              return _bookmarkResultCard(state.items[index]);
            },
          ),
        );
      }
    }
  }

  Widget _bookmarkResultCard(UserInfo item) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.elliptical(20, 20),
        ),
      ),
      child: ListTile(
          leading: Image.network(
            item.avatarUrl,
            width: 56,
            height: 56,
          ),
          title: Text(item.name.toString()),
          subtitle: Text(item.login),
          onTap: () {
            _onClickCard(context, item);
          },
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () => _deleteBookmark(item.login),
              ),
            ],
          )),
    );
  }

  Widget _bookmarkEmptyView() {
    return Expanded(
      child: Center(
        child: Text('No bookmarked items'),
      ),
    );
  }
}
