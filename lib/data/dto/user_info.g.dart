// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      (json['total_count'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'items': instance.items,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      login: json['login'] as String,
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      avatarUrl: json['avatar_url'] as String,
      followers: (json['followers'] as num?)?.toInt(),
      following: (json['following'] as num?)?.toInt(),
      isBookmarked: json['isBookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'followers': instance.followers,
      'following': instance.following,
      'isBookmarked': instance.isBookmarked,
    };
