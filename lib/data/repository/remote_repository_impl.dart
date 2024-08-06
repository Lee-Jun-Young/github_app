import '../api/api_github_service.dart';
import '../../domain/repository/remote_repository.dart';
import '../di/locator.dart';
import '../dto/user_info.dart';
import '../dto/user_repository.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  final ApiGithubService _api = inject<ApiGithubService>();

  @override
  Future<SearchResponse> getSearchedUser(String login, int page) async {
    return _api.searchUser(login, page);
  }

  @override
  Future<UserInfo> getDetailUserByLogin(String login) async {
    return _api.getUserById(login);
  }

  @override
  Future<UserInfo> getMyData() async {
    return await _api.getUser();
  }

  @override
  Future<List<RepositoryInfo>> getRepos(String owner) async {
    return _api.getRepos(owner);
  }
}
