import 'dart:convert';

BookRommModel bookRommModelFromJson(String str) => BookRommModel.fromJson(json.decode(str));

String bookRommModelToJson(BookRommModel data) => json.encode(data.toJson());

class BookRommModel {
  BookRommModel({
    required this.requestDate,
    required this.meetingRoomId,
    required this.bookerName,
    required this.fromDate,
    required this.toDate,
    required this.notes,
    required this.userName,
    required this.description,
  });

  String requestDate;
  int meetingRoomId;
  String bookerName;
  String fromDate;
  String toDate;
  String notes;
  String userName;
  String description;

  factory BookRommModel.fromJson(Map<String, dynamic> json) => BookRommModel(
    requestDate: json["Request_Date"],
    meetingRoomId: json["Meeting_Room_ID"],
    bookerName: json["Booker_Name"],
    fromDate: json["From_Date"],
    toDate: json["To_Date"],
    notes: json["Notes"],
    userName: json["UserName"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Request_Date": requestDate,
    "Meeting_Room_ID": meetingRoomId,
    "Booker_Name": bookerName,
    "From_Date": fromDate,
    "To_Date": toDate,
    "Notes": notes,
    "UserName": userName,
    "Description": description,
  };
}
