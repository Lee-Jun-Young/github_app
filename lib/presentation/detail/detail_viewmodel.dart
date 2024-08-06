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

  bool isLoaded = false;

  UserData get userInfo => _userInfo;
  late UserData _userInfo = UserData(UserInfo.empty(), []);

  Future<void> _loadDetailData(String login) async {
    final userInfo = await _remoteRepository.getDetailUserByLogin(login);
    final repoInfo = await _remoteRepository.getRepos(login);
    _userInfo = UserData(userInfo, repoInfo);
    isLoaded = true;
    notifyListeners();
  }
}
