import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_app/data/api/api_github_service.dart';

import '../api/custom_log_interceptor.dart';
import '../database/database_helper.dart';
import '../repository/local_repository_impl.dart';
import '../repository/remote_repository_impl.dart';

final inject = GetIt.instance;

void initGetIt() async {
  inject.registerLazySingleton(
      () => Dio()..interceptors.add(CustomLogInterceptor()));

  inject.registerLazySingleton(() => ApiGithubService(inject()));

  inject.registerLazySingleton(() => RemoteRepositoryImpl());

  inject.registerLazySingleton(() => DatabaseHelper());

  inject.registerLazySingleton(() => LocalRepositoryImpl());
}
