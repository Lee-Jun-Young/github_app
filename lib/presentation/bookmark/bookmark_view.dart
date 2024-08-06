import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dto/user_info.dart';
import '../detail/detail_page.dart';
import 'bookmark_viewmodel.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  _BookmarkViewState createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  late BookmarkViewModel viewModel;

  Future<void> cardClickEvent(BuildContext context, UserInfo item) async {
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

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<BookmarkViewModel>(context);

    return Scaffold(
      body: _bookmarkList(onDelete: (String login) {
        setState(() {
          viewModel.deleteBookmark(login);
        });
      }),
    );
  }

  Widget _bookmarkList({required Function(String) onDelete}) {
    final items = viewModel.item;
    final isLoaded = viewModel.isLoaded;

    if (isLoaded == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (items.isEmpty) {
        return const Center(
          child: Text('No bookmarked items'),
        );
      } else {
        return Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(20, 20),
                  ),
                ),
                child: ListTile(
                    leading: Image.network(
                      items[index].avatarUrl,
                      width: 56,
                      height: 56,
                    ),
                    title: Text(items[index].name.toString()),
                    subtitle: Text(items[index].login),
                    onTap: () {
                      cardClickEvent(context, items[index]);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            onDelete(items[index].login);
                          },
                        ),
                      ],
                    )),
              );
            },
          ),
        );
      }
    }
  }
}
