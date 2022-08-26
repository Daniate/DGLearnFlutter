// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity()
  ..age = json['age'] as int?
  ..avatarUrlString = json['avatarUrl'] as String?
  ..hexColorString = json['color'] as String?
  ..email = json['email'] as String?
  ..id = json['id'] as int?
  ..isPublic = json['isPublic'] as bool?
  ..name = json['name'] as String?
  ..statusMessage = json['statusMessage'] as String?;

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'age': instance.age,
      'avatarUrl': instance.avatarUrlString,
      'color': instance.hexColorString,
      'email': instance.email,
      'id': instance.id,
      'isPublic': instance.isPublic,
      'name': instance.name,
      'statusMessage': instance.statusMessage,
    };
