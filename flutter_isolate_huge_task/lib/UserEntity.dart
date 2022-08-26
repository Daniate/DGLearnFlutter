import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

/*
{
  "age": 77,
  "avatarUrl": "https://i.pravatar.cc/150?u=80796",
  "color": "#CEDD42",
  "email": "#gnzvzj@mgjdo.iu",
  "id": 1,
  "isPublic": true,
  "name": "RhuZicvVd7",
  "statusMessage": "watching Netflix"
}
 */
part 'UserEntity.g.dart';

/// 用户
@JsonSerializable()
class UserEntity {
  UserEntity();

  int? age;

  /// 头像Url
  @JsonKey(name: "avatarUrl")
  String? avatarUrlString;

  @JsonKey(name: "color")
  String? hexColorString;

  /// 邮箱
  String? email;

  /// 用户ID
  int? id;

  bool? isPublic;

  /// 昵称
  String? name;

  String? statusMessage;

  static List<UserEntity> fromJsonList(List<dynamic> jsonList) {
    return List<UserEntity>.from(jsonList.map((i) {
      return UserEntity.fromJson(i);
    }));
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
