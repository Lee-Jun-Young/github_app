import 'package:json_annotation/json_annotation.dart';

part 'user_repository.g.dart';

@JsonSerializable()
class RepositoryInfo {
  String name;
  bool private;
  String? description;
  @JsonKey(name: 'stargazers_count')
  int stargazersCount;
  @JsonKey(name: 'forks_count')
  int forksCount;

  RepositoryInfo({
    required this.name,
    required this.private,
    this.description,
    required this.stargazersCount,
    required this.forksCount,
  });

  factory RepositoryInfo.fromJson(Map<String, dynamic> json) =>
      _$RepositoryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryInfoToJson(this);
}
