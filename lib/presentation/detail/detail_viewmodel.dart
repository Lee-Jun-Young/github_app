import 'package:flutter/cupertino.dart';
import 'package:github_app/data/repository/remote_repository_impl.dart';

import '../../data/di/locator.dart';
import '../../data/dto/user_info.dart';
import '../../domain/repository/remote_repository.dart';

class DetailViewModel with ChangeNotifier {
  final RemoteRepository _remoteRepository;

  DetailViewModel(String login, {RemoteRepository? remoteRepository})
      : _remoteRepository = remoteRepository ?? inject<RemoteRepositoryImpl>() {
    _loadDetailData(login);
  }

  DetailState _state = DetailState.initial();

  DetailState get state => _state;

  Future<void> _loadDetailData(String login) async {
    final userInfo = await _remoteRepository.getDetailUserByLogin(login);
    final repoData = await _remoteRepository.getRepos(userInfo.login);
    _state = _state.copyWith(
      isLoaded: true,
      items: UserData(userInfo, repoData),
    );
    notifyListeners();
  }
}

class DetailState {
  final bool isLoaded;
  final UserData items;

  DetailState({
    required this.isLoaded,
    required this.items,
  });

  factory DetailState.initial() {
    return DetailState(isLoaded: false, items: UserData(UserInfo.empty(), []));
  }

  DetailState copyWith({
    bool? isLoaded,
    UserData? items,
  }) {
    return DetailState(
      isLoaded: isLoaded ?? this.isLoaded,
      items: items ?? this.items,
    );
  }
}
