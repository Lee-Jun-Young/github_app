import 'package:flutter/material.dart';
import '../../data/di/locator.dart';
import '../../data/dto/user_info.dart';
import '../../data/dto/user_repository.dart';
import '../../data/repository/remote_repository_impl.dart';
import '../../domain/repository/remote_repository.dart';

class HomeViewModel with ChangeNotifier {
  final RemoteRepository _remoteRepository;

  HomeViewModel({RemoteRepository? remoteRepository})
      : _remoteRepository = remoteRepository ?? inject<RemoteRepositoryImpl>() {
    _loadMyData();
  }

  bool isLoaded = false;

  UserData get userInfo => _userInfo;
  late UserData _userInfo = UserData(UserInfo.empty(), []);

  Future<void> _loadMyData() async {
    final userData = await _remoteRepository.getMyData();
    final repoData = await _remoteRepository.getRepos(userData.login);
    _userInfo = UserData(userData, repoData);
    isLoaded = true;
    notifyListeners();
  }
}
