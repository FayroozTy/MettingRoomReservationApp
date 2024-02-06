import 'dart:convert';

BookRoomResponse bookRoomResponseFromJson(String str) => BookRoomResponse.fromJson(json.decode(str));

String bookRoomResponseToJson(BookRoomResponse data) => json.encode(data.toJson());

class BookRoomResponse {
  BookRoomResponse({
    this.errorDesc,
    required this.resultObject,
    required this.status,
  });

  dynamic errorDesc;
  int resultObject;
  String status;

  factory BookRoomResponse.fromJson(Map<String, dynamic> json) => BookRoomResponse(
    errorDesc: json["Error_Desc"],
    resultObject: json["Result_Object"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Error_Desc": errorDesc,
    "Result_Object": resultObject,
    "Status": status,
  };
}
