// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  int meetingRoomBookingId;
  String requestDate;
  int meetingRoomId;
  String roomCode;
  String roomName;
  bool isActive;
  String fromDate;
  String toDate;
  String bookerName;
  Description description;
  bool approved;
  bool rejected;
  String notes;
  UserName userName;
  String timeStamp;

  OrdersModel({
    required this.meetingRoomBookingId,
    required this.requestDate,
    required this.meetingRoomId,
    required this.roomCode,
    required this.roomName,
    required this.isActive,
    required this.fromDate,
    required this.toDate,
    required this.bookerName,
    required this.description,
    required this.approved,
    required this.rejected,
    required this.notes,
    required this.userName,
    required this.timeStamp,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    meetingRoomBookingId: json["Meeting_Room_Booking_ID"],
    requestDate: (json["Request_Date"]),
    meetingRoomId: json["Meeting_Room_ID"],
    roomCode: json["Room_Code"],
    roomName: json["Room_Name"],
    isActive: json["IsActive"],
    fromDate: (json["From_Date"]),
    toDate: (json["To_Date"]),
    bookerName: json["Booker_Name"],
    description: descriptionValues.map[json["Description"]]!,
    approved: json["Approved"],
    rejected: json["Rejected"],
    notes: json["Notes"],
    userName: userNameValues.map[json["User_Name"]]!,
    timeStamp: (json["Time_Stamp"]),
  );

  Map<String, dynamic> toJson() => {
    "Meeting_Room_Booking_ID": meetingRoomBookingId,
    "Request_Date": requestDate,
    "Meeting_Room_ID": meetingRoomId,
    "Room_Code": roomCode,
    "Room_Name": roomName,
    "IsActive": isActive,
    "From_Date": fromDate,
    "To_Date": toDate,
    "Booker_Name": bookerName,
    "Description": descriptionValues.reverse[description],
    "Approved": approved,
    "Rejected": rejected,
    "Notes": notes,
    "User_Name": userNameValues.reverse[userName],
    "Time_Stamp": timeStamp,
  };
}

enum Description {
  DES
}

final descriptionValues = EnumValues({
  "des": Description.DES
});

enum UserName {
  ADMIN,
  NULL,
  USER_NAME_ADMIN
}

final userNameValues = EnumValues({
  "admin": UserName.ADMIN,
  "null": UserName.NULL,
  "admin ": UserName.USER_NAME_ADMIN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
