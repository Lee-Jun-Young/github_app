import 'package:flutter/material.dart';
import 'package:github_app/data/repository/local_repository_impl.dart';
import 'package:github_app/domain/repository/local_repository.dart';

import '../../data/di/locator.dart';
import '../../data/dto/user_info.dart';

class BookmarkViewModel with ChangeNotifier {
  final LocalRepository _localRepository;

  BookmarkViewModel({LocalRepository? localRepository})
      : _localRepository = localRepository ?? inject<LocalRepositoryImpl>() {
    getBookmarkedItems();
  }

  List<UserInfo> get item => _item;
  late List<UserInfo> _item = [];

  bool isLoaded = false;

  Future<void> getBookmarkedItems() async {
    _item = await _localRepository.getBookmarkList();
    isLoaded = true;
    notifyListeners();
  }

  Future<void> deleteBookmark(String login) async {
    await _localRepository.deleteBookmark(login);
    getBookmarkedItems();
  }

  Future<void> insertBookmark(UserInfo item) async {
    await _localRepository.insertBookmark(item);
    getBookmarkedItems();
  }
}
