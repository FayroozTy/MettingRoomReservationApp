import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:reservation_app/Model/user/BookingBriefList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/BookingFullList.dart';
import '../Model/UndoRejectRoomBookin.dart';
import '../Model/UserResponse.dart';
import '../Model/user/BookRommModel.dart';
import '../Model/user/BookingBriefList.dart';
import '../Model/user/BookingBriefList.dart';
import '../Model/user/BookingBriefList.dart';
import '../Model/user/BookingBriefList.dart';
import '../Model/user/BookingFullListForRoom.dart';
import '../Model/user/bookRoomResponse.dart';
import '../Model/user/data.dart';
import '../Model/user/user_info.dart';

import '../Utli/Constatns.dart';
import 'logging.dart';

import 'package:http/http.dart' as http;


Future<UserResponse?> LoginPostRequest ( UserInfo userInfo) async {
  var url =  BaseURL + 'api/Resp/SignIn';

  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map data = {
    "UserName": userInfo.username,
    "Password": userInfo.password,
    "Program_Copy_ID": "100",

  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.body}");

  if (response.body.contains("An error has occurred")){
    return null;
  }

  else{
    return userResponseFromJson(response.body);
  }



}

Future<BookRoomResponse?> BookRoomRequest ( BookRommModel roomModel) async {
  var url =  BaseURL + 'api/Booking/BookRoom';

  Map data = {
    "Request_Date":  roomModel.requestDate,
    "Meeting_Room_ID": roomModel.meetingRoomId,
    "Booker_Name": roomModel.bookerName,
    "From_Date": roomModel.fromDate,
    "To_Date": roomModel.toDate,
    "Notes": roomModel.notes,
    "UserName": roomModel.userName,
    "Description":roomModel.description
  };
  print(data);
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.body}");

  if (response.body.contains("An error has occurred")){
    return null;
  }

  else{
    return bookRoomResponseFromJson(response.body);
  }



}

//api/Booking/BookingBriefList
Future<List<BookingBriefList>> getBookingBriefList () async {
  //String url =  BaseURL + 'api/Booking/BookRoom';

  final url = Uri.parse('$BaseURL/api/Booking/MeetingRoomList');
  var response = await get(url);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');

  return bookingBriefListFromJson(response.body);


}

Future<List<BookingFullListForRoom>> getBookingFullListForRoom (int Meeting_Room_ID ) async {
  //String url =  BaseURL + 'api/Booking/BookRoom';

  final url = Uri.parse('$BaseURL/api/Booking/BookingFullListForRoom/$Meeting_Room_ID');
  var response = await get(url);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');


  //final response = await http.get(Uri.parse(url));



  return bookingFullListForRoomFromJson(response.body);


}

Future<List<BookingFullList>> getBookingFullList ( ) async {
  //String url =  BaseURL + 'api/Booking/BookRoom';

  final url = Uri.parse('$BaseURL/api/Booking/BookingFullList');
  var response = await get(url);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');


  //final response = await http.get(Uri.parse(url));



  return BookingFullListFromJson(response.body);


}

Future  AcceptRoomBooking (int Meeting_Room_ID ) async {

  print(Meeting_Room_ID);
  //String url =  BaseURL + 'api/Booking/BookRoom';

  final url = Uri.parse('$BaseURL/api/Booking/AcceptRoomBooking/$Meeting_Room_ID');
  var response = await get(url);
  print('Status code: ${response.statusCode}');

  //print('Headers: ${response.headers}');
  print('Body: ${response.body}');


  //final response = await http.get(Uri.parse(url));



  return (response.body);


}

Future  RejectRoomBooking (int Meeting_Room_ID , String RejectReason ) async {
  //String url =  BaseURL + 'api/Booking/BookRoom';

  // final url = Uri.parse('$BaseURL/api/Booking/RejectRoomBooking');
  // Map data = {
  //   "Meeting_Room_Booking_ID": Meeting_Room_ID,
  //   "RejectReason": RejectReason,
  //
  //
  // };
  // //encode Map to JSON
  // var body = json.encode(data);
  //
  // var response = await http.post(url,
  //     headers: {"Content-Type": "application/json"},
  //     body: body
  // );
  // print("${response.body}");
  //
  //
  // print('Status code: ${response.statusCode}');
  // print('Headers: ${response.headers}');
  // print('Body: ${response.body}');


  //final response = await http.get(Uri.parse(url));



  //return (response.body);
  print("resone");
  print(RejectReason);


  return http.post(Uri.parse('$BaseURL/api/Booking/RejectRoomBooking'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  }, body: jsonEncode(<String, dynamic>{
    "Meeting_Room_Booking_ID": Meeting_Room_ID,
    "RejectReason": RejectReason
  }),);


}

Future  LoginIsAdmin (String name ) async {
  //String url =  BaseURL + 'api/Booking/BookRoom';

  final url = Uri.parse('$BaseURL/api/Booking/LoginIsAdmin/' + name.trim());

  print('url: ${url}');
  var response = await get(url);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');


  //final response = await http.get(Uri.parse(url));



  return (response.body);


}



Future  UndoAcceptRoomBooking (int Meeting_Room_Booking_ID ) async {
  //String url =  BaseURL + 'api/Booking/BookRoom';

  final url = Uri.parse('$BaseURL/api/Booking/UndoAcceptRoomBooking/$Meeting_Room_Booking_ID');
  print('url: ${url}');

  var response = await get(url);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');


  //final response = await http.get(Uri.parse(url));



  return (response.body);


}

Future  UndoRejectRoomBooking (int Meeting_Room_Booking_ID,String RejectReason  ) async {
  //String url =  BaseURL + 'api/Booking/BookRoom';
  //
  // final url = Uri.parse('$BaseURL/api/Booking/UndoRejectRoomBooking');
  //
  // Map data =
  // {
  //   "RejectReason": RejectReason,
  //   "Meeting_Room_Booking_ID": Meeting_Room_Booking_ID
  // };
  // print(data);
  // //encode Map to JSON
  // var body = json.encode(data);
  // print(body);
  //
  // var response = await http.post(url,
  //     headers: {"Content-Type": "application/json"},
  //     body: body
  // );
  // print("${response.body}");
  // print('url: ${url}');



  http.Response
  response1 = await http.post(Uri.parse('$BaseURL/api/Booking/UndoRejectRoomBooking'), headers: <String, String>{
    "Accept":
    "application/json",
    "Access-Control-Allow-Credentials":
    "*",
    "content-type":
    "application/json"
  }, body: jsonEncode(<String, dynamic>{
  "RejectReason": RejectReason,
  "Meeting_Room_Booking_ID": Meeting_Room_Booking_ID
  }),);

  print(response1.body);
  print(response1.statusCode);




  //final response = await http.get(Uri.parse(url));



  return (response1.body);


}



Future  AddDeviceToken (int Citizen_ID,String Token  ) async {
  //String url =  BaseURL + 'api/Booking/BookRoom';

  final url = Uri.parse('$Token_BaseURL/api/Notification/AddDeviceToken');

  Map data =
  {
    "Token": Token,
    "Citizen_ID": Citizen_ID,
    "Notes": "note"
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("AddDeviceToken : ${response.body}");
  print('url: ${url}');




  //final response = await http.get(Uri.parse(url));



  return (response.body);


}