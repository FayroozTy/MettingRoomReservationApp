
import 'dart:convert';

List<BookingBriefList> bookingBriefListFromJson(String str) => List<BookingBriefList>.from(json.decode(str).map((x) => BookingBriefList.fromJson(x)));

String bookingBriefListToJson(List<BookingBriefList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingBriefList {
  BookingBriefList({
    required this.meetingRoomId,
    required  this.roomCode,
    required this.roomName,
  });

  int meetingRoomId;
  String roomCode;
  String roomName;

  factory BookingBriefList.fromJson(Map<String, dynamic> json) => BookingBriefList(
    meetingRoomId: json["Meeting_Room_ID"],
    roomCode: json["Room_Code"],
    roomName: json["Room_Name"],
  );

  Map<String, dynamic> toJson() => {
    "Meeting_Room_ID": meetingRoomId,
    "Room_Code": roomCode,
    "Room_Name": roomName,
  };
}


// class TransactionDetails {
//   int? meetingRoomId;
//   String? roomCode;
//   String? roomName;
//
//
//   TransactionDetails({
//     this.meetingRoomId,
//     this.roomCode,
//     this.roomName,
//
//   });
//
//   TransactionDetails.fromJson(Map<String, dynamic> json) {
//     meetingRoomId = json['Meeting_Room_ID'];
//     roomCode = json['Room_Code'];
//     roomName = json['Room_Name'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['Meeting_Room_ID'] = meetingRoomId;
//     data['Room_Code'] = roomCode;
//     data['Room_Name'] = roomName;
//
//     return data;
//   }
// }