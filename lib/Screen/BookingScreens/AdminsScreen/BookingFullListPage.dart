import 'package:flutter/material.dart';



import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservation_app/Screen/BookingScreens/UsersScreen/reserveScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import '../../../Model/BookingFullList.dart';
import '../../../Model/user/BookingBriefList.dart';
import '../../../Model/user/BookingFullListForRoom.dart';
import '../../../Services/dio_client.dart';
import '../../../Utli/Constatns.dart';
import '../../puplicScreens/loginPage.dart';

import 'dart:io';

import 'package:intl/intl.dart';




class BookingListScreen extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BookingListScreen();
  }

}

class _BookingListScreen extends State<BookingListScreen> {

  bool loading = false;
  late ScrollController _controller;
  bool visible = false ;
  DateTime now = new DateTime.now();
  DateTime TodateTime = new DateTime.now();
  late List<BookingFullList> FullListForRoom = [];

  late List<BookingFullList> ApprovedFullListForRoom = [];

  var _MsgTxtcontroller = TextEditingController();
  @override
  void initState()  {
    super.initState();
    visible = false;
    _controller = ScrollController();
    _quryData();

  }
  subOnCharecter({required String str, required int from, required int to}) {
    var runes = str.runes.toList();
    String result = '';
    for (var i = from; i < to; i++) {
      result = result + String.fromCharCode(runes[i]);
    }
    return result;
  }
  _quryData(){

    FullListForRoom = [];
    ApprovedFullListForRoom = [];
    getBookingFullList ().then((result) async {
      loading = true;


      setState(() {
        loading = false;
        FullListForRoom = result;
        for (var item in FullListForRoom){
          if(item.approved){

            TodateTime  = DateTime.parse(item.toDate);
            print(TodateTime);
            print(now);



            if( TodateTime.year < now.year){
              print(" before");
            }
            if (TodateTime.month > now.month){
              ApprovedFullListForRoom.add(item);
            }else if(TodateTime.day < now.day){
              print(" before");
            }else{
              ApprovedFullListForRoom.add(item);
            }





          }
        }


      });

    });
  }



  Widget build(BuildContext context) {

    // showLoaderDialog(context);
    return Scaffold(

        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),

          title: Center(child: Text("قائمة الحجوزات المعتمدة", style: TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.white))),




          backgroundColor: CustomColors.backgroundColor,


        ),
        body:
        ApprovedFullListForRoom.length != 0 ?
        RefreshIndicator(
          onRefresh: () {
            return        getBookingFullList ().then((result) async {
              loading = true;


              setState(() {
                loading = false;
                FullListForRoom = [];
                ApprovedFullListForRoom = [];
                FullListForRoom = result;
                for (var item in FullListForRoom){
                  if(item.approved) {


                    TodateTime  = DateTime.parse(item.toDate);
                    print(TodateTime);
                    print(now);


                    if( TodateTime.year < now.year){
                      print(" before");
                    }
                    if (TodateTime.month > now.month){
                      ApprovedFullListForRoom.add(item);
                    }else if(TodateTime.day < now.day){
                      print(" before");
                    }else{
                      ApprovedFullListForRoom.add(item);
                    }




                   // }




                  }





                  }
              });

            });
          },
          child: ListView.separated(
            controller: _controller,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            reverse: false,
            padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 100),
            itemCount: ApprovedFullListForRoom.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  showNotesDialog(context,"التفاصيل" , ApprovedFullListForRoom[index].notes);
                 // showAlertDialogMSG( context ,ApprovedFullListForRoom[index].notes);
                },
                child: Container(

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
                    child:

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    // IconButton(
                    //   onPressed: (){
                    //     EditshowDialogBox(RejectedFullListForRoom[index].meetingRoomBookingId);
                    //   },
                    //   icon:  Icon(Icons.undo, color: Colors.grey,size: 30,),
                    // ),


                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,

                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,


                          children: [

                            IconButton(
                              onPressed: (){
                                EditshowDialogBox(ApprovedFullListForRoom[index].meetingRoomBookingId);
                              },
                              icon:  Icon(Icons.undo, color: Colors.grey,size: 30,),
                            ),
                            Text(ApprovedFullListForRoom[index].roomName.toString(),
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontFamily: "Al-Jazeera-Arabic-Bold",
                                    fontSize: 15)),


                          ],
                        ),


                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,


                          children: [
                            Row(
                              children: [
                                Center(

                                  child:  Text(ApprovedFullListForRoom[index].fromDate.split("T")[0].trim() + " "
                                      +subOnCharecter(str:  ApprovedFullListForRoom[index].fromDate.split("T")[1].trim(), from: 0, to: 4)
                                      ,
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF686868),
                                          fontFamily: "Al-Jazeera-Arabic-Bold",
                                          fontSize: 15)),
                                ),
                                SizedBox(width: 4,),
                                Center(

                                  child:  Text("التاريخ من ",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF686868),
                                          fontFamily: "Al-Jazeera-Arabic-Regular",
                                          fontSize: 15)),
                                ),

                              ],
                            ),


                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Center(

                              child:  Text(ApprovedFullListForRoom[index].toDate.split("T")[0].trim() + " "
                                  +subOnCharecter(str:  ApprovedFullListForRoom[index].toDate.split("T")[1].trim(), from: 0, to: 4),
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xFF686868),
                                      fontFamily: "Al-Jazeera-Arabic-Bold",
                                      fontSize: 15)),
                            ),
                            SizedBox(width: 4,),
                            Center(

                              child:  Text("التاريخ الى ",
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xFF686868),
                                      fontFamily: "Al-Jazeera-Arabic-Regular",
                                      fontSize: 15)),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),

                        Container (
                          width: MediaQuery.of(context).size.width,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [


                              Expanded(
                                  child:
                                  Text(

                                    textAlign: TextAlign.right,


                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Al-Jazeera-Arabic-bold"),
                                    ApprovedFullListForRoom[index].notes,
                                    softWrap: false,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,))
                              ,
                              SizedBox(width: 8,),



                            ],
                          ),
                        ),
                        SizedBox(height: 10,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,


                          children: [
                            Text(ApprovedFullListForRoom[index].bookerName.toString(),


                                style: TextStyle(

                                    color: Colors.indigo,
                                    fontFamily: "Al-Jazeera-Arabic-Bold",
                                    fontSize: 15))


                          ],
                        ),



                      ],
                    )
                ),
              );

              //     ],
              //   ),
              // );
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 20,
            ),
          ),
        ): loading == true ?
        Center(child: CircularProgressIndicator()):

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[


            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Center(
                    child: Text(
                      "لا تتوفر بيانات حاليا",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.deepOrange,
                          fontFamily: "Al-Jazeera-Arabic-Bold"),
                    ),
                  ),
                  SizedBox(height: 10,),

                  InkWell(
                      onTap:(){
                        getBookingFullList ().then((result) async {
                          loading = true;


                          setState(() {
                            loading = false;
                            FullListForRoom = [];
                            ApprovedFullListForRoom = [];
                            FullListForRoom = result;
                            for (var item in FullListForRoom){
                              if(!item.approved && !item.rejected){
                                ApprovedFullListForRoom.add(item);
                              }
                            }
                          });

                        });
                      },child: Icon(Icons.refresh_sharp, color: Colors.black))
                ]

            ),

          ],
        ),







    );
  }
  PopshowDialogBox() =>
      showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('تنبيه'),
          content: const Text('هل تود التاكيد على تسجل الخروج'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("isLogin", "false");

                Navigator.of(context, rootNavigator: true).pop("Discard");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => loginPage()));
              },
              child: const Text('موافق'),
            ),

            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');

              },
              child: const Text('الغاء'),
            )
          ],
        ),
      );

  EditshowDialogBox( int meetingRoomBookingId ) =>
      showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('', style: TextStyle(
              color: Colors.black,
              fontFamily: "Al-Jazeera-Arabic-Bold",
              fontSize: 14)),
          content: const Text('هل تود التراجع عن موافقة الحجز', style: TextStyle(
              color: Colors.black,
              fontFamily: "Al-Jazeera-Arabic-Bold",
              fontSize: 16)),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                showLoaderDialog(context);

                UndoAcceptRoomBooking (meetingRoomBookingId).then((result) async {
                  Navigator.of(context, rootNavigator: true).pop("Discard");
                  Navigator.pop(context, 'Cancel');
                  print(result );


                  setState(() {

                    if (result == "true"){
                      _quryData();
                      showAlertDialogs(context , "نبيه" , "تمت العملية بنجاح");

                    }else{
                      showAlertDialogs(context , "نبيه" , "خطا في البيانات");
                    }


                  });

                });


              },
              child: const Text('موافق'),
            ),

            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');

              },
              child: const Text('الغاء'),
            )
          ],
        ),
      );



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

  showAlertDialogMSG(BuildContext context , String content) {

    // // set up the button
    // Widget okButton = TextButton(
    //   child: Text("OK"),
    //   onPressed: () { },
    // );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text("سبب الحجز", style: TextStyle(fontFamily: "Al-Jazeera-Arabic-Bold"))),
      content: Directionality(textDirection: ui.TextDirection.rtl,
          child: Text(content,style: TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular"))),
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


  showNotesDialog(BuildContext context, String title, String msg) {

    // set up the button


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title,style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontFamily: "Al-Jazeera-Arabic-Regular"),textAlign: TextAlign.center,),
      content: Text(msg,style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
          fontFamily: "Al-Jazeera-Arabic-bold"),textAlign: TextAlign.center),

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}