// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    username: json['UserName'] as String,
    password: json['Password'] as String,
    deviceOsTypeId: json['Program_Copy_ID'] as String,


  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'UserName': instance.username,
      'Password': instance.password,
      'Program_Copy_ID': instance.deviceOsTypeId,

    };
