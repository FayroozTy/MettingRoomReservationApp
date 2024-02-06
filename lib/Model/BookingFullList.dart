import 'dart:convert';
List<BookingFullList> BookingFullListFromJson(String str) => List<BookingFullList>.from(json.decode(str).map((x) => BookingFullList.fromJson(x)));

String BookingFullListToJson(List<BookingFullList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingFullList {
  BookingFullList({
    required this.meetingRoomBookingId,
    required this.requestDate,
    required this.meetingRoomId,
    required this.roomCode,
    required this.roomName,
    required this.isActive,
    required this.fromDate,
    required this.toDate,
    required  this.bookerName,
    required this.description,
    required this.approved,
    required  this.rejected,
    required  this.notes,
    required this.userName,
    required this.timeStamp,
  });

  int meetingRoomBookingId;
  String requestDate;
  int meetingRoomId;
  String roomCode;
  String roomName;
  bool isActive;
  String fromDate;
  String toDate;
  String bookerName;
  String description;
  bool approved;
  bool rejected;
  String notes;
  String userName;
  String timeStamp;



  factory BookingFullList.fromJson(Map<String, dynamic> json) => BookingFullList(
    meetingRoomBookingId: json["Meeting_Room_Booking_ID"],
    requestDate: json["Request_Date"],
    meetingRoomId: json["Meeting_Room_ID"],
    roomCode: json["Room_Code"],
    roomName: json["Room_Name"],
    isActive: json["IsActive"],
    fromDate: json["From_Date"],
    toDate: json["To_Date"],
    bookerName: json["Booker_Name"],
    description: json["Description"],
    approved: json["Approved"],
    rejected: json["Rejected"],

    notes: json["Notes"],
      userName: json["User_Name"],
      timeStamp: json["Time_Stamp"]
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
    "Description": description,
    "Approved": approved,
    "Rejected": rejected,
    "Notes": notes,
    "User_Name": userName,
    "Time_Stamp": timeStamp,
  };
}
