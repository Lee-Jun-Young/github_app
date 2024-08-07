import 'package:flutter/material.dart';

import '../../data/di/locator.dart';
import '../../data/dto/user_info.dart';
import '../../data/repository/remote_repository_impl.dart';
import '../../domain/repository/remote_repository.dart';

class HomeViewModel with ChangeNotifier {
  final RemoteRepository _remoteRepository;

  HomeViewModel({RemoteRepository? remoteRepository})
      : _remoteRepository = remoteRepository ?? inject<RemoteRepositoryImpl>() {
    _loadMyData();
  }

  HomeState _state = HomeState.initial();

  HomeState get state => _state;

  Future<void> _loadMyData() async {
    final userData = await _remoteRepository.getMyData();
    final repoData = await _remoteRepository.getRepos(userData.login);
    _state = _state.copyWith(
      isLoaded: true,
      items: UserData(userData, repoData),
    );
    notifyListeners();
  }
}

class HomeState {
  final bool isLoaded;
  final UserData items;

  HomeState({
    required this.isLoaded,
    required this.items,
  });

  factory HomeState.initial() {
    return HomeState(isLoaded: false, items: UserData(UserInfo.empty(), []));
  }

  HomeState copyWith({
    bool? isLoaded,
    UserData? items,
  }) {
    return HomeState(
      isLoaded: isLoaded ?? this.isLoaded,
      items: items ?? this.items,
    );
  }
}
