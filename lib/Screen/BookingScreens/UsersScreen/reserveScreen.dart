import 'package:flutter/material.dart';



import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/user/BookRommModel.dart';
import '../../../Model/user/BookingBriefList.dart';
import '../../../Services/dio_client.dart';
import '../../../Utli/Constatns.dart';
import 'package:date_time_picker/date_time_picker.dart';


// This has back button and drawer
class reserveScreen extends StatefulWidget {
  final int roomsid;
  final String roomName;

  const reserveScreen({super.key, required this.roomsid, required this.roomName});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _reserveScreen(roomsid,roomName);
  }


}

class _reserveScreen extends State<reserveScreen> {
  final int roomid;
  final String roomName;
  late TextEditingController _Request_DateController;
  late TextEditingController _From_DateController;
  late TextEditingController _To_DateController;
  late TextEditingController _Booker_NameController;
  late TextEditingController _NotesController;
   bool loading = false;

    late TextEditingController _controller;
   List<String> rooms = [""];
  List<String> Disrooms = [""];
   String selectval = "";
  int selectval_id = 1;
  // int selectvalId = 1;
    TextEditingController dateInput = TextEditingController();
  late List<BookingBriefList> roomsList;
  String loginName = "";
  String finaltime2 = "";

  String reqTime = "";
  String reqDate = "";


  final _dateController = TextEditingController();
  final _timeController1 = TextEditingController();
  final _dateControllerT = TextEditingController();
  final _timeControllerT = TextEditingController();

  _reserveScreen(this.roomid, this.roomName);


  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _Request_DateController = TextEditingController();
    _From_DateController = TextEditingController();
    _To_DateController = TextEditingController();
    _Booker_NameController = TextEditingController();
    _NotesController = TextEditingController();
     dateInput.text = "";
     selectval_id = roomid ;
     getLoginName();

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
     reqTime = DateFormat("hh:mm").format(now);
     reqDate = formatter.format(now);

    setState(() {
      loading = false;

    });


  }

  getLoginName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginName =   prefs.getString("loginName") ?? "";
    });

  }
  Widget _datePicker() {
    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "التاريخ",
        icon: Icon(Icons.event),
        hintText: "",
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: DateTime.now(),
          lastDate: DateTime(2024),

        );
        if (selectedDate != null) {
          setState(() {

            _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          });
        }
      },
    );
  }
  Widget _timePicker() {
    return TextField(
      controller: _timeController1,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "الوقت",
        icon: Icon(Icons.punch_clock_sharp),
        hintText: "",
      ),
      onTap: ()  async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),

        );

        if (selectedTime != null) {


          var df = DateFormat("h:mm");
          var dt = df.parse(selectedTime!.format(context));
          var dt2 =  dt.add(const Duration(minutes: 30));
          setState(() {
            finaltime2 =  DateFormat('HH:mm').format(dt2);
            print(finaltime2);
          });



          var finaltime =  DateFormat('HH:mm').format(dt);


          // final text =  selectedTime.to24hours();
             // selectedTime.format(context);
          setState(() {
            _timeController1.text = finaltime;
          });
        }
      },
    );
  }


  Widget _datePickerT() {
    return TextField(
      readOnly: true,
      controller: _dateControllerT,
      decoration: InputDecoration(
        labelText: _dateController.text != "" ? _dateController.text : "",
        icon: Icon(Icons.event),
        hintText: "",
      ),
    //     decoration: InputDecoration(
    //       icon: Icon(Icons.event),
    //     contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 20),
    //     hintText:_dateController.text != "" ? _dateController.text : "",
    //    hintStyle: TextStyle(
    //     fontSize: 15.0,color: Colors.black,fontFamily: "Al-Jazeera-Arabic-Regular"
    // ),),

    onTap: () async {
        final selectedDate = await showDatePicker(
          firstDate: DateTime.now(),
          initialDate: DateTime.now(),
          lastDate: DateTime(2024), context: context,

        );
        if (selectedDate != null) {
          setState(() {
            _dateControllerT.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          });
        }
      },
    );
  }
  Widget _timePickerT() {
    return TextField(
      controller: _timeControllerT,
      readOnly: true,
      decoration: InputDecoration(
        labelText: finaltime2 != "" ? finaltime2 : "",
        icon: Icon(Icons.punch_clock_sharp),
        hintText: "",
      ),

      onTap: ()  async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),

        );

        if (selectedTime != null) {


          var df = DateFormat("h:mm");
          var dt = df.parse(selectedTime!.format(context));
          var finaltime =  DateFormat('HH:mm').format(dt);


          // final text =  selectedTime.to24hours();
          // selectedTime.format(context);
          setState(() {


              _timeControllerT.text = finaltime;

          });
        }
      },
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


  showAlertDialogs(BuildContext context , String title , String content) {

    // set up the button
    // Widget okButton = TextButton(
    //   child: Text("موافق"),
    //   onPressed: () {
    //     Navigator.of(context, rootNavigator: true).pop("Discard");
    //     Navigator.pop(context, 'Cancel');
    //   },
    // );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundColor,
        title: Center(child: Text(roomName, style: TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.white))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context),
        ),
      ),

      body:  Padding(
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[


            SizedBox(height: 15,),

            Container(

              margin: const EdgeInsets.only(left: 4.0, right: 4.0),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border(
                  right: BorderSide(width: 4.0, color: CustomColors.backgroundColor),
                  // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                ),
                color: Colors.white,
              ),
              child: Column(

                children: [

                  Center(
                    child: Text("فترة الحجز من" ,style:
                    TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.blueGrey)),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  _datePicker(),
                  _timePicker(),
                  SizedBox(
                    height: 10,
                  ),



                ],
              ),
            ),
            SizedBox(height: 20,),
            loading== true? Center(child: CircularProgressIndicator()): Container(),
            Container(

              margin: const EdgeInsets.only(left: 4.0, right: 4.0),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border(
                  right: BorderSide(width: 4.0, color: CustomColors.backgroundColor),
                  // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                ),
                color: Colors.white,
              ),
              child: Column(

                children: [

                  Center(
                    child: Text("فترة الحجز الى" ,style:
                    TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.blueGrey)),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  _datePickerT(),
                  _timePickerT(),
                  SizedBox(
                    height: 10,
                  ),


                  // Padding(
                  //   padding: EdgeInsets.only(right: 10,left: 10),
                  //   child: DateTimePicker(
                  //     type: DateTimePickerType.dateTimeSeparate,
                  //     dateMask: 'd MMM, yyyy',
                  //     initialValue: _From_DateController.text ,
                  //     firstDate: DateTime(2000),
                  //     lastDate: DateTime(2100),
                  //     icon: Icon(Icons.event),
                  //     dateLabelText: 'التاريخ',
                  //     timeLabelText: "الوقت",
                  //     selectableDayPredicate: (date) {
                  //       // Disable weekend days to select from the calendar
                  //       if (date.weekday == 6 || date.weekday == 7) {
                  //         return false;
                  //       }
                  //
                  //       return true;
                  //     },
                  //       onChanged: (val) {
                  //         print("ffff");
                  //         _To_DateController.text = val.toString();
                  //         print( _To_DateController.text);
                  //         print(val);
                  //       } ,
                  //       validator: (val) {
                  //         print(val);
                  //         _To_DateController.text = val.toString();
                  //         print( _To_DateController.text);
                  //         return null;
                  //       },
                  //     onSaved: (val)  {
                  //       setState(() {
                  //         _To_DateController.text = val.toString() ;
                  //       });
                  //     } ,
                  //   ),
                  // ),
                  // SizedBox(height: 10,),
                  //  SizedBox(height: 5),
                  //3rd row


                ],
              ),
            ),

            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                  width: 200,
                  height: 45,
                  child: TextFormField(

                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (_newValue) {

                        setState(() {
                          _Booker_NameController.value = TextEditingValue(
                            text: _newValue,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: _newValue.length),
                            ),
                          );
                        });

                      },


                      controller: _Booker_NameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 20, 10, 20),
                         labelStyle: TextStyle(
                             fontSize: 14.0,color: Colors.black,fontFamily: "Al-Jazeera-Arabic-Regular"
                         ),

                        labelText: "$loginName",
                        hintStyle: TextStyle(
                            fontSize: 13.0,color: Colors.grey,fontFamily: "Al-Jazeera-Arabic-Regular"
                        ),



                        // label: Center(
                        //   child: Text(lableText,style: TextStyle(
                        //       fontSize: 14.0,color: Color(0xFF44a2a9),fontFamily: "Al-Jazeera-Arabic-Regular"
                        //   ),),
                        // ),


                        //
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      )
                  ),
                ),

                Text("طالب الحجز" ,style:
                TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.black)),
              ],
            ),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.only(right: 20,left: 20),
              child: Container(

                child: TextFormField(

                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 10, // <-- SEE HERE
                    minLines: 1, // <-- SEE HERE
                    keyboardType: TextInputType.multiline,

                    onChanged: (_newValue) {

                      setState(() {
                        _NotesController.value = TextEditingValue(
                          text: _newValue,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: _newValue.length),
                          ),
                        );
                      });

                    },


                    controller: _NotesController,
                    decoration: InputDecoration(
                      isDense: true, // important line
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 50),
                      //contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      hintText:"ملاحظات",
                      hintStyle: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                          fontFamily: "Al-Jazeera-Arabic-Regular"
                      ),



                      // label: Center(
                      //   child: Text(lableText,style: TextStyle(
                      //       fontSize: 14.0,color: Color(0xFF44a2a9),fontFamily: "Al-Jazeera-Arabic-Regular"
                      //   ),),
                      // ),


                      //
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    )
                ),
              ),
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [



                SizedBox(width: 4,),

                ElevatedButton(
                    child: Text(
                        "احجز القاعة ".toUpperCase(),
                        style: TextStyle(fontSize: 14,fontFamily: "Al-Jazeera-Arabic-bold")
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)
                            )
                        )
                    ),
                    onPressed: () async {



                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        print("selectval_id$selectval_id");

                        print(_dateController.text);

                        print(_dateControllerT.text);

                        if (_dateController.text == ""){
                         showAlertDialogs(context, "نبيه",
                                  "خطا في الادخال يرجى التاكد من البيانات");
                             }

                        else {
                          if (_dateControllerT.text != "") {
                            final date1 = DateTime.parse(_dateController.text);
                            final date2 = DateTime.parse(_dateControllerT.text);

                            if (date2.isBefore(date1)) {
                              showAlertDialogs(context, "نبيه",
                                  "خطا في الادخال يرجى التاكد من البيانات");
                            } else {


                              String Totime = _timeControllerT.text != ""
                                  ? _timeControllerT.text
                                  : finaltime2;

                              String  requestDate1 = "$reqDate T$reqTime:00";
                              print(requestDate1);

                              BookRommModel room = BookRommModel(
                                requestDate:reqDate + "T" + reqTime,
                                meetingRoomId: selectval_id,
                                bookerName: _Booker_NameController.text == ""
                                    ? loginName
                                    : _Booker_NameController.text,
                                fromDate: _dateController.text + "T" +
                                    _timeController1.text,


                                toDate: _dateControllerT.text == ""
                                    ? _dateController.text + "T" + Totime
                                    :
                                _dateControllerT.text + "T" + Totime,


                                notes: _NotesController.text,
                                userName: prefs.getString("username").toString(),
                                description: "des",


                              );

                              setState(() {
                                loading = true;

                              });



                              BookRoomRequest(room).then((result) async {
                                print("response: $result");

                                setState(() {
                                  loading = false;

                                });


                                //  Navigator.pop(context);

                                if (result == null) {
                                  showAlertDialog(
                                      context, "نبيه", "خطا في البيانات");
                                  setState(() {

                                  });
                                } else {
                                  if (result?.status == "Success") {
                                    showAlertDialog(
                                        context, "نبيه", "تم الحجز بنجاح");

                                    setState(() {
                                      _Request_DateController.text = "";
                                      _From_DateController.text = "";
                                      _To_DateController.text = "";
                                      _Booker_NameController.text = "";
                                      _NotesController.text = "";
                                    });
                                  }
                                  else {
                                    showAlertDialog(
                                        context, "نبيه", "خطا في الارسال");

                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  }
                                }
                              });
                            }

                          }
                          else {


                            String Totime = _timeControllerT.text != ""
                                ? _timeControllerT.text
                                : finaltime2;

                            BookRommModel room = BookRommModel(
                              requestDate: reqDate + "T" + reqTime,
                              meetingRoomId: selectval_id,
                              bookerName: _Booker_NameController.text == ""
                                  ? loginName
                                  : _Booker_NameController.text,
                              fromDate: _dateController.text + "T" +
                                  _timeController1.text,


                              toDate: _dateControllerT.text == ""
                                  ? _dateController.text + "T" + Totime
                                  :
                              _dateControllerT.text + "T" + Totime,


                              notes: _NotesController.text,
                              userName: prefs.getString("username").toString(),
                              description: "des",


                            );

                            setState(() {
                              loading = true;

                            });



                            BookRoomRequest(room).then((result) async {
                              print("response: $result");

                              setState(() {
                                loading = false;

                              });


                              //  Navigator.pop(context);

                              if (result == null) {
                                showAlertDialog(
                                    context, "نبيه", "خطا في البيانات");
                                setState(() {

                                });
                              } else {
                                if (result?.status == "Success") {
                                  showAlertDialog(
                                      context, "نبيه", "تم الحجز بنجاح");

                                  setState(() {
                                    _Request_DateController.text = "";
                                    _From_DateController.text = "";
                                    _To_DateController.text = "";
                                    _Booker_NameController.text = "";
                                    _NotesController.text = "";
                                  });
                                }
                                else {
                                  showAlertDialog(
                                      context, "نبيه", "خطا في الارسال");
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            });
                          }
                        }







                    }
                ),




                SizedBox(width: 4,),

              ],
            ),

          ],
        ),
      ),
    );
  }
    OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
      return OutlineInputBorder( //Outline border type for TextFeild
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color:CustomColors.backgroundColor,
            width: 1,
          )
      );
    }

    OutlineInputBorder myfocusborder(){
      return OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color:CustomColors.backgroundColor,
            width: 1,
          )
      );
    }
}
showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}







