import 'package:flutter/material.dart';



import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservation_app/Screen/BookingScreens/UsersScreen/reserveScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/BookingFullList.dart';
import '../../../Model/user/BookingBriefList.dart';
import '../../../Model/user/BookingFullListForRoom.dart';
import '../../../Services/dio_client.dart';
import '../../../Utli/Constatns.dart';
import '../../puplicScreens/loginPage.dart';








class RejectedListPage extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RejectedListPage();
  }

}

class _RejectedListPage extends State<RejectedListPage> {

  bool loading = false;
  late ScrollController _controller;
  bool visible = false ;
  DateTime now = new DateTime.now();
  DateTime TodateTime = new DateTime.now();
  late List<BookingFullList> FullListForRoom = [];

  late List<BookingFullList> RejectedFullListForRoom = [];

  var _MsgTxtcontroller = TextEditingController();
  @override
  void initState()  {
    super.initState();
    visible = false;
    _controller = ScrollController();
    _quryData();

  }

  _quryData(){
    getBookingFullList ().then((result) async {
      loading = true;


      setState(() {
        loading = false;
        FullListForRoom = result;
        for (var item in FullListForRoom){
          if(item.rejected){

            TodateTime  = DateTime.parse(item.toDate);
            print(TodateTime);
            print(now);




            if( TodateTime.year < now.year){
              print(" before");
            }
            if (TodateTime.month > now.month){
              RejectedFullListForRoom.add(item);
            }else if(TodateTime.day < now.day){
              print(" before");
            }else{
              RejectedFullListForRoom.add(item);
            }





          }
        }
      });

    });
  }

  subOnCharecter({required String str, required int from, required int to}) {
    var runes = str.runes.toList();
    String result = '';
    for (var i = from; i < to; i++) {
      result = result + String.fromCharCode(runes[i]);
    }
    return result;
  }


  Widget build(BuildContext context) {

    // showLoaderDialog(context);
    return Scaffold(

        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),

          title: Center(child: Text("قائمة الحجوزات المرفوضة", style: TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.white))),




          backgroundColor: CustomColors.backgroundColor,


        ),
        body:
        RejectedFullListForRoom.length != 0 ?
        RefreshIndicator(
          onRefresh: () {
            return     getBookingFullList ().then((result) async {
              loading = true;


              setState(() {
                loading = false;

                FullListForRoom = [];
                RejectedFullListForRoom = [];
                FullListForRoom = result;
                for (var item in FullListForRoom){
                  if(item.rejected){

                    TodateTime  = DateTime.parse(item.toDate);
                    print(TodateTime);
                    print(now);



    if( TodateTime.year < now.year){
    print(" before");
    }
    if (TodateTime.month > now.month){
      RejectedFullListForRoom.add(item);
    }else if(TodateTime.day < now.day){
    print(" before");
    }else{
      RejectedFullListForRoom.add(item);
    }







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
            itemCount: RejectedFullListForRoom.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  showNotesDialog(context,"التفاصيل" , RejectedFullListForRoom[index].notes);

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
                                  EditshowDialogBox(RejectedFullListForRoom[index].meetingRoomBookingId);
                                },
                                icon:  Icon(Icons.undo, color: Colors.grey,size: 30,),
                              ),
                              Text(RejectedFullListForRoom[index].roomName.toString(),
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

                                    child:  Text(RejectedFullListForRoom[index].fromDate.split("T")[0].trim() + " "
                                        +subOnCharecter(str:  RejectedFullListForRoom[index].fromDate.split("T")[1].trim(), from: 0, to: 4)
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

                                child:  Text(RejectedFullListForRoom[index].toDate.split("T")[0].trim() + " "
                                    +subOnCharecter(str:  RejectedFullListForRoom[index].toDate.split("T")[1].trim(), from: 0, to: 4),
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
                                      RejectedFullListForRoom[index].notes,
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
                              Text(RejectedFullListForRoom[index].bookerName.toString(),


                                  style: TextStyle(

                                      color: Colors.indigo,
                                      fontFamily: "Al-Jazeera-Arabic-Bold",
                                      fontSize: 15)),

                              TextButton (


                                onPressed: ()  async {

                                  showAlertDialogs(context , "سبب الرفض" , RejectedFullListForRoom[index].notes);




                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: CustomColors.backgroundColor,

                                  shape: RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                )
                                ,


                                child: Center(
                                  child: Text(

                                    "تفاصيل الرفض",
                                    style: TextStyle( decoration: TextDecoration.underline,color: Color(0xFFF5F5F5),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14),
                                  ),
                                ),
                              ),


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
                              RejectedFullListForRoom = [];
                              FullListForRoom = result;
                              for (var item in FullListForRoom){
                                if(item.rejected){
                                  RejectedFullListForRoom.add(item);
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



  EditshowDialogBox(int Meeting_Room_Booking_ID) =>
      showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('تنبيه'),
          content: const Text('هل تود التراجع عن رفض الحجز'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {


                _showAlert( Meeting_Room_Booking_ID);


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



  _showAlert(int Meeting_Room_Booking_ID) {
    return


      showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return

            AlertDialog(
              content:

              visible == false?  new Container(
                width: 300.0,
                height: 250.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xFFFFFF),
                  borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,


                  children: <Widget>[
                    // dialog top


                    // dialog centre
                    new Container(



                        child: new TextField(

                          // textDirection: TextDirection.rtl,
                          showCursor: true,

                          textAlign: TextAlign.center,
                          controller: _MsgTxtcontroller,
                          maxLines: 10, // <-- SEE HERE
                          minLines: 1, // <-- SEE HERE
                          keyboardType: TextInputType.multiline,
                          decoration: new InputDecoration(

                            isDense: true, // important line
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 2),//
                            border: InputBorder.none,
                            filled: false,

                            hintText: ' ادخل الملاحظات',
                            hintStyle: new TextStyle(

                              color: Colors.grey.shade500,
                              fontSize: 12.0,
                              fontFamily: 'Al-Jazeera-Arabic-Regular',
                            ),
                          ),
                          onChanged: (val){

                          },


                        )),


                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                            onTap: () async {

                             // _MsgTxtcontroller.text = "";

                              Navigator.of(context, rootNavigator: true).pop("Discard");
                              Navigator.pop(context, 'Cancel');

                              showLoaderDialog(context);


                              UndoRejectRoomBooking (Meeting_Room_Booking_ID , _MsgTxtcontroller.text).then((result) async {

                                print(result );


                                setState(() {

                                  if (result == "true"){
                                    RejectedFullListForRoom= [];
                                    _quryData();
                                    showAlertDialogs(context , "نبيه" , "تمت العملية بنجاح");
                                    Navigator.of(context, rootNavigator: true).pop("Discard");
                                    Navigator.pop(context, 'Cancel');


                                  }else{
                                    RejectedFullListForRoom= [];
                                    _quryData();
                                    showAlertDialogs(context , "نبيه" , "خطا في البيانات");
                                    Navigator.of(context, rootNavigator: true).pop("Discard");
                                    Navigator.pop(context, 'Cancel');

                                  }


                                });

                              });









                            },
                            child: (
                                new Container(

                                    height: 35,
                                    width:  MediaQuery
                                        .of(context)
                                        .size
                                        .width,

                                    decoration: new BoxDecoration(
                                      color:  CustomColors.backgroundColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [




                                        Text(
                                          'ارسل ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontFamily: 'Al-Jazeera-Arabic-Regular',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )



                                ))
                        ),
                      ),
                    ),



                  ],
                ),
              ): Container(
                padding: const EdgeInsets.all(50),
                margin:const EdgeInsets.all(50) ,
                color:Colors.white,
                //widget shown according to the state
                child: Center(
                  child:
                  CircularProgressIndicator(),
                ),


              ),
            );;
        });
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

