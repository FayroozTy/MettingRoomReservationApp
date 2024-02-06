import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  String username;
  String password;
  String? deviceOsTypeId;



  UserInfo({
    required this.username,
    required this.password,
    this.deviceOsTypeId,


  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
