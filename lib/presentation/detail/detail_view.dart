import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dto/user_info.dart';
import '../../data/dto/user_repository.dart';
import '../bookmark/bookmark_viewmodel.dart';
import 'detail_viewmodel.dart';

class DetailView extends StatelessWidget {
  late DetailViewModel viewModel;
  late BookmarkViewModel bookmarkViewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<DetailViewModel>(context);
    bookmarkViewModel = Provider.of<BookmarkViewModel>(context);

    return Scaffold(appBar: AppBar(), body: _detailScreen(context));
  }

  Widget _detailScreen(BuildContext context) {
    final item = viewModel.userInfo;
    final isLoaded = viewModel.isLoaded;
    final isBookmarked = bookmarkViewModel.item
        .any((element) => element.login == item.userInfo.login);

    if (!isLoaded) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          Navigator.pop(context, isBookmarked);
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailUserInfoView(context, item.userInfo),
                  _repositoryList(item.repoInfo)
                ],
              ),
            ),
            _bookmarkButton(isBookmarked, context, item.userInfo),
          ],
        ),
      );
    }
  }

  Widget _detailUserInfoView(BuildContext context, UserInfo item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.network(item.avatarUrl,
              height: 150,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill),
          SizedBox(height: 8),
          Text(item.name.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(item.login, style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _repositoryList(List<RepositoryInfo> repoInfo) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: repoInfo.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(repoInfo[index].name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(repoInfo[index].description ?? 'No description'),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _bookmarkButton(
      bool isBookmarked, BuildContext context, UserInfo item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: isBookmarked
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border),
          iconSize: 50.0,
          onPressed: () {
            if (isBookmarked) {
              bookmarkViewModel.deleteBookmark(item.login);
            } else {
              bookmarkViewModel.insertBookmark(item);
            }
          },
        ),
      ),
    );
  }
}
