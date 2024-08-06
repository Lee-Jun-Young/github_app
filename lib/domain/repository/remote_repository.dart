import '../../data/dto/user_info.dart';
import '../../data/dto/user_repository.dart';

abstract class RemoteRepository {
  Future<SearchResponse> getSearchedUser(String login, int page);

  Future<UserInfo> getDetailUserByLogin(String login);

  Future<UserInfo> getMyData();

  Future<List<RepositoryInfo>> getRepos(String owner);
}
