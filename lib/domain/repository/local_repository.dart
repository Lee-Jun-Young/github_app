import '../../data/dto/user_info.dart';

abstract class LocalRepository {
  Future<List<UserInfo>> getBookmarkList();

  Future<void> deleteBookmark(String login);

  Future<void> insertBookmark(UserInfo userInfo);
}
