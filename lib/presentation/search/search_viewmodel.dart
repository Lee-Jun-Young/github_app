import 'package:flutter/cupertino.dart';

import '../../data/di/locator.dart';
import '../../data/dto/user_info.dart';
import '../../data/repository/remote_repository_impl.dart';
import '../../domain/repository/remote_repository.dart';

class SearchViewModel with ChangeNotifier {
  final RemoteRepository _remoteRepository;

  SearchViewModel({RemoteRepository? remoteRepository})
      : _remoteRepository = remoteRepository ?? inject<RemoteRepositoryImpl>();

  SearchState _state = SearchState.initial();

  SearchState get state => _state;

  Future<void> searchQuery(String login) async {
    _state = _state.copyWith(
      isFirst: false,
      isLoaded: false,
      searchText: login,
      page: 1,
    );
    notifyListeners();

    final data = await _remoteRepository.getSearchedUser(login, _state.page);
    _state = _state.copyWith(
      totalCount: data.totalCount,
      items: data.items,
      isLoaded: true,
    );
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_state.items.length >= _state.totalCount) {
      return;
    }

    final nextPage = _state.page + 1;
    final data =
        await _remoteRepository.getSearchedUser(_state.searchText, nextPage);

    _state = _state.copyWith(
      page: nextPage,
      items: [..._state.items, ...data.items],
    );
    notifyListeners();
  }
}

class SearchState {
  final int totalCount;
  final int page;
  final String searchText;
  final bool isLoaded;
  final bool isFirst;
  final List<UserInfo> items;

  SearchState({
    required this.totalCount,
    required this.page,
    required this.searchText,
    required this.isLoaded,
    required this.isFirst,
    required this.items,
  });

  factory SearchState.initial() {
    return SearchState(
      totalCount: 0,
      page: 1,
      searchText: '',
      isLoaded: false,
      isFirst: true,
      items: [],
    );
  }

  SearchState copyWith({
    int? totalCount,
    int? page,
    String? searchText,
    bool? isLoaded,
    bool? isFirst,
    List<UserInfo>? items,
  }) {
    return SearchState(
      totalCount: totalCount ?? this.totalCount,
      page: page ?? this.page,
      searchText: searchText ?? this.searchText,
      isLoaded: isLoaded ?? this.isLoaded,
      isFirst: isFirst ?? this.isFirst,
      items: items ?? this.items,
    );
  }
}
