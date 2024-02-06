// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.errorDesc,
    required  this.resultObject,
    required this.status,
  });

  dynamic errorDesc;
  ResultObject resultObject;
  String status;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    errorDesc: json["Error_Desc"],
    resultObject: ResultObject.fromJson(json["Result_Object"]),
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Error_Desc": errorDesc,
    "Result_Object": resultObject.toJson(),
    "Status": status,
  };
}

class ResultObject {
  ResultObject({
    required this.apiPassword,
    required this.apiUserName,
    required  this.collectorId,
    required this.encryptedLoginPassword,
    required  this.encryptedDbLoginPwd,
    required this.loginStatus,
    required  this.mustChangeLoginPassword,
    required this.canChangeLoginPassword,
    required this.loginActiveToDate,
    required this.loginActiveFromDate,
    required this.dbLoginPwd,
    required this.dbLoginName,
    required this.loginPassword,
    required this.employeeId,
    required this.loginId,
    this.accessToken,
    required this.loginName,
    required this.Employee_Name,
    required this.Employee_Citizen_ID
  });

  String apiPassword;
  String apiUserName;
  int collectorId;
  String encryptedLoginPassword;
  String encryptedDbLoginPwd;
  int loginStatus;
  bool mustChangeLoginPassword;
  bool canChangeLoginPassword;
  DateTime loginActiveToDate;
  DateTime loginActiveFromDate;
  String dbLoginPwd;
  String dbLoginName;
  String loginPassword;
  int employeeId;
  int loginId;
  dynamic accessToken;
  String loginName;
  String Employee_Name;
  int Employee_Citizen_ID;

  factory ResultObject.fromJson(Map<String, dynamic> json) => ResultObject(
    apiPassword: json["Api_Password"],
    apiUserName: json["Api_User_Name"],
    collectorId: json["Collector_ID"],
    encryptedLoginPassword: json["Encrypted_Login_Password"],
    encryptedDbLoginPwd: json["Encrypted_DB_Login_PWD"],
    loginStatus: json["Login_Status"],
    mustChangeLoginPassword: json["Must_Change_Login_Password"],
    canChangeLoginPassword: json["Can_Change_Login_Password"],
    loginActiveToDate: DateTime.parse(json["Login_Active_To_Date"]),
    loginActiveFromDate: DateTime.parse(json["Login_Active_From_Date"]),
    dbLoginPwd: json["DB_Login_PWD"],
    dbLoginName: json["DB_Login_Name"],
    loginPassword: json["Login_Password"],
    employeeId: json["Employee_ID"],
    loginId: json["Login_ID"],
    accessToken: json["Access_Token"],
    loginName: json["Login_Name"],
    Employee_Name: json["Employee_Name"],
      Employee_Citizen_ID: json["Employee_Citizen_ID"]
  );

  Map<String, dynamic> toJson() => {
    "Api_Password": apiPassword,
    "Api_User_Name": apiUserName,
    "Collector_ID": collectorId,
    "Encrypted_Login_Password": encryptedLoginPassword,
    "Encrypted_DB_Login_PWD": encryptedDbLoginPwd,
    "Login_Status": loginStatus,
    "Must_Change_Login_Password": mustChangeLoginPassword,
    "Can_Change_Login_Password": canChangeLoginPassword,
    "Login_Active_To_Date": loginActiveToDate.toIso8601String(),
    "Login_Active_From_Date": loginActiveFromDate.toIso8601String(),
    "DB_Login_PWD": dbLoginPwd,
    "DB_Login_Name": dbLoginName,
    "Login_Password": loginPassword,
    "Employee_ID": employeeId,
    "Login_ID": loginId,
    "Access_Token": accessToken,
    "Login_Name": loginName,
    "Employee_Name": Employee_Name,
    "Employee_Citizen_ID": Employee_Citizen_ID
  };
}
