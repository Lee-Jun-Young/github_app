import 'package:github_app/data/dto/user_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class SearchResponse {
  @JsonKey(name: 'total_count')
  final int totalCount;
  final List<UserInfo> items;

  SearchResponse(this.totalCount, {required this.items});

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable()
class UserInfo {
  String login;
  int id;
  String? name;
  @JsonKey(name: 'avatar_url')
  String avatarUrl = "";
  int? followers;
  int? following;
  bool isBookmarked = false;

  UserInfo(
      {required this.login,
      required this.id,
      required this.name,
      required this.avatarUrl,
      required this.followers,
      required this.following,
      required this.isBookmarked});

  UserInfo.empty()
      : login = '',
        id = 0,
        name = '',
        avatarUrl = '',
        followers = 0,
        following = 0,
        isBookmarked = false;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  Map<String, dynamic> get toMap => {
        'login': login,
        'id': id,
        'name': name,
        'avatarUrl': avatarUrl,
        'followers': followers,
        'following': following,
        'isBookmarked': isBookmarked,
      };
}

class UserData {
  final UserInfo userInfo;
  final List<RepositoryInfo> repoInfo;

  UserData(this.userInfo, this.repoInfo);
}
