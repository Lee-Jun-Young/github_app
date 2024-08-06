import '../../domain/repository/local_repository.dart';
import '../database/database_helper.dart';
import '../di/locator.dart';
import '../dto/user_info.dart';

class LocalRepositoryImpl implements LocalRepository {
  final DatabaseHelper _dbHelper = inject<DatabaseHelper>();

  @override
  Future<List<UserInfo>> getBookmarkList() async {
    return await _dbHelper.getTodos();
  }

  @override
  Future<void> deleteBookmark(String login) async {
    await _dbHelper.deleteTodo(login);
  }

  @override
  Future<void> insertBookmark(UserInfo userInfo) async {
    await _dbHelper.insertTodo(userInfo);
  }
}
