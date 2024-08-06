import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/user_info.dart';
import '../dto/user_repository.dart';

part 'api_github_service.g.dart';

@RestApi(baseUrl: "https://api.github.com/")
abstract class ApiGithubService {
  factory ApiGithubService(Dio dio, {String? baseUrl}) = _ApiGithubService;

  @GET('user')
  Future<UserInfo> getUser();

  @GET('users/{owner}/repos')
  Future<List<RepositoryInfo>> getRepos(@Path('owner') String owner);

  @GET('users/{user}')
  Future<UserInfo> getUserById(@Path('user') String user);

  @GET("search/users")
  Future<SearchResponse> searchUser(
      @Query("q") String query, @Query("page") int page);
}
