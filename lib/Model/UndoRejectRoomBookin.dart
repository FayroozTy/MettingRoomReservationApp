
import 'dart:convert';

UndoRejectRoomBookin undoRejectRoomBookinFromJson(String str) => UndoRejectRoomBookin.fromJson(json.decode(str));

String undoRejectRoomBookinToJson(UndoRejectRoomBookin data) => json.encode(data.toJson());

class UndoRejectRoomBookin {
  UndoRejectRoomBookin({
    required this.rejectReason,
    required this.meetingRoomBookingId,
  });

  String rejectReason;
  int meetingRoomBookingId;

  factory UndoRejectRoomBookin.fromJson(Map<String, dynamic> json) => UndoRejectRoomBookin(
    rejectReason: json["RejectReason"],
    meetingRoomBookingId: json["Meeting_Room_Booking_ID"],
  );

  Map<String, dynamic> toJson() => {
    "RejectReason": rejectReason,
    "Meeting_Room_Booking_ID": meetingRoomBookingId,
  };
}
