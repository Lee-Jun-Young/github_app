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

  BookmarkState _state = BookmarkState.initial();

  BookmarkState get state => _state;

  Future<void> getBookmarkedItems() async {
    final items = await _localRepository.getBookmarkList();
    _state = _state.copyWith(
      isLoaded: true,
      items: items,
    );
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

  bool isBookmarked(String login) {
    return _state.items.any((element) => element.login == login);
  }
}

class BookmarkState {
  final bool isLoaded;
  final List<UserInfo> items;

  BookmarkState({
    required this.isLoaded,
    required this.items,
  });

  factory BookmarkState.initial() {
    return BookmarkState(
      isLoaded: false,
      items: [],
    );
  }

  BookmarkState copyWith({
    bool? isLoaded,
    List<UserInfo>? items,
  }) {
    return BookmarkState(
      isLoaded: isLoaded ?? this.isLoaded,
      items: items ?? this.items,
    );
  }
}
