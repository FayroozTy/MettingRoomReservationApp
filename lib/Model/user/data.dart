import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String avatar;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}






ReturnedApiLoginData returnedApiLoginDataFromJson(String str) => ReturnedApiLoginData.fromJson(json.decode(str));

String returnedApiLoginDataToJson(ReturnedApiLoginData data) => json.encode(data.toJson());

class ReturnedApiLoginData {
  ReturnedApiLoginData({
    required this.Error_Desc,
    required this.Result_Object,


  });

  String? Error_Desc;

  result_Object Result_Object;


  factory ReturnedApiLoginData.fromJson(Map<String, dynamic> json) => ReturnedApiLoginData(
    Error_Desc: json["Error_Desc"],
    Result_Object: json["Result_Object"],

  );

  Map<String, dynamic> toJson() => {
    "Error_Desc": Error_Desc,
    "Result_Object": Result_Object,

  };
}



class result_Object {
  result_Object({
    required this.Api_Password,
    required this.Api_User_Name,
    required this.Collector_ID,
    required this.Encrypted_Login_Password,
    required this.Login_Name,
    required this.Encrypted_DB_Login_PWD,


  });

  String Api_Password;

  String Api_User_Name;
  String Collector_ID;

  String Encrypted_Login_Password;
  String Login_Name;

  String Encrypted_DB_Login_PWD;


  factory result_Object.fromJson(Map<String, dynamic> json) => result_Object(
    Api_Password: json["Api_Password"],
    Api_User_Name: json["Api_User_Name"],
    Collector_ID: json["Collector_ID"],
    Encrypted_Login_Password: json["Encrypted_Login_Password"],
    Encrypted_DB_Login_PWD: json["Encrypted_DB_Login_PWD"],
    Login_Name: json["Login_Name"]
  );

  Map<String, dynamic> toJson() => {
    "Api_Password": Api_Password,
    "Api_User_Name": Api_User_Name,
    "Collector_ID": Collector_ID,
    "Encrypted_Login_Password": Encrypted_Login_Password,
    "Encrypted_DB_Login_PWD": Encrypted_DB_Login_PWD,
    "Login_Name": Login_Name,

  };
}
