// To parse this JSON data, do
//
//     final bookingFullListForRoom = bookingFullListForRoomFromJson(jsonString);

import 'dart:convert';

List<BookingFullListForRoom> bookingFullListForRoomFromJson(String str) => List<BookingFullListForRoom>.from(json.decode(str).map((x) => BookingFullListForRoom.fromJson(x)));

String bookingFullListForRoomToJson(List<BookingFullListForRoom> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingFullListForRoom {
  BookingFullListForRoom({
    required this.meetingRoomBookingId,
    required  this.requestDate,
    required this.meetingRoomId,
    required this.roomCode,
    required this.roomName,
    required this.isActive,
    required this.fromDate,
    required this.toDate,
    required this.bookerName,
    required  this.description,
    required this.approved,
    required this.rejected,
    required  this.notes,
    required  this.userName,
    required this.timeStamp,
  });

  int meetingRoomBookingId;
  DateTime requestDate;
  int meetingRoomId;
  String roomCode;
  String roomName;
  bool isActive;
  DateTime fromDate;
  DateTime toDate;
  String bookerName;
  String description;
  bool approved;
  bool rejected;
  String notes;
  String userName;
  DateTime timeStamp;

  factory BookingFullListForRoom.fromJson(Map<String, dynamic> json) => BookingFullListForRoom(
    meetingRoomBookingId: json["Meeting_Room_Booking_ID"],
    requestDate: DateTime.parse(json["Request_Date"]),
    meetingRoomId: json["Meeting_Room_ID"],
    roomCode: json["Room_Code"],
    roomName: json["Room_Name"],
    isActive: json["IsActive"],
    fromDate: DateTime.parse(json["From_Date"]),
    toDate: DateTime.parse(json["To_Date"]),
    bookerName: json["Booker_Name"],
    description: json["Description"],
    approved: json["Approved"],
    rejected: json["Rejected"],
    notes: json["Notes"],
    userName: json["User_Name"],
    timeStamp: DateTime.parse(json["Time_Stamp"]),
  );

  Map<String, dynamic> toJson() => {
    "Meeting_Room_Booking_ID": meetingRoomBookingId,
    "Request_Date": requestDate.toIso8601String(),
    "Meeting_Room_ID": meetingRoomId,
    "Room_Code": roomCode,
    "Room_Name": roomName,
    "IsActive": isActive,
    "From_Date": fromDate.toIso8601String(),
    "To_Date": toDate.toIso8601String(),
    "Booker_Name": bookerName,
    "Description": description,
    "Approved": approved,
    "Rejected": rejected,
    "Notes": notes,
    "User_Name": userName,
    "Time_Stamp": timeStamp.toIso8601String(),
  };
}
