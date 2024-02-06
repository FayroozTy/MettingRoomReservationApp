import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservation_app/Screen/BookingScreens/UsersScreen/reserveScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/user/BookingBriefList.dart';
import '../../../../../Model/user/BookingFullListForRoom.dart';
import '../../../../../Services/dio_client.dart';
import '../../../../../Utli/Constatns.dart';
import '../../../../puplicScreens/loginPage.dart';


class bookingLisScreen extends StatefulWidget{
  final int roomid;
  final String roomName;


  bookingLisScreen(this.roomid, this.roomName);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _bookingLisScreen(roomid,roomName);
  }

}

class _bookingLisScreen extends State<bookingLisScreen> {

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  final int roomid;
  final String roomName;
  bool loading = true;
  _bookingLisScreen(this.roomid, this.roomName);


  late List<BookingFullListForRoom> FullListForRoom = [];

  @override
  void didChangeDependencies() {
    // TODO: implem;ent didChangeDependencies
    super.didChangeDependencies();
    print("fff");


  }



  @override
  void initState()  {
    super.initState();

    getBookingFullListForRoom (roomid).then((result) async {
      setState(() {
        loading = true;
      });


      //  Navigator.of(context, rootNavigator: true).pop("Discard");

      setState(() {
        loading = false;
        FullListForRoom = result;


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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(

            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Center(child: Text(roomName, style: TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.white))),

            elevation: .1,

            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_circle_sharp,
                  color:Colors.white,


                ),
                onPressed: ()async {
                  final value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  reserveScreen(roomsid: roomid,roomName: roomName,))
                  ,).then((_) => setState(() {
                    loading = true;
                    getBookingFullListForRoom (roomid).then((result) async {


                      setState(() {
                        loading = false;
                        FullListForRoom = result;


                      });

                    });


                  }));
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  reserveScreen(roomsid: roomid,roomName: roomName,)));


                  // do something
                },
              )
            ],

            backgroundColor: CustomColors.backgroundColor,


          ),
          body:
          FullListForRoom.length != 0 ?
          RefreshIndicator(
            onRefresh: () {
             return getBookingFullListForRoom (roomid).then((result) async {
                loading = true;

                setState(() {
                  FullListForRoom = [];
                  loading = false;
                  FullListForRoom = result;


                });

              });
            },
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: false,
              padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 200),
              itemCount: FullListForRoom.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    showNotesDialog(context,"التفاصيل",FullListForRoom[index].notes );
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
                        Column(

                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,


                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(

                                      child:  Text( " "+  FullListForRoom[index].fromDate.toString().split(" ")[0].trim() + " "
                            +subOnCharecter(str:  FullListForRoom[index].fromDate.toString().split(" ")[1].trim(), from: 0, to: 5),



                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF686868),
                                              fontFamily: "Al-Jazeera-Arabic-Bold",
                                              fontSize: 17)),
                                    ),
                                    Center(

                                      child:  Text( "  "+ "التاريخ من  ",
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF686868),
                                              fontFamily: "Al-Jazeera-Arabic-Bold",
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

                                  child:  Text( " " +  FullListForRoom[index].toDate.toString().split(" ")[0].trim() + " "
                                +subOnCharecter(str:  FullListForRoom[index].toDate.toString().split(" ")[1].trim(), from: 0, to: 5),

                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF686868),
                                          fontFamily: "Al-Jazeera-Arabic-Bold",
                                          fontSize: 17)),
                                ),
                                Center(

                                  child:  Text( "  "+"التاريخ الى " ,
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF686868),
                                          fontFamily: "Al-Jazeera-Arabic-Bold",
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
                                        FullListForRoom[index].notes,
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,))
                                  ,
                                  SizedBox(width: 8,),



                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row
                              (mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text(

                                  FullListForRoom[index].rejected == false &&  FullListForRoom[index].approved == false ? "الحجز بالنتظار ":
                              FullListForRoom[index].rejected == true &&  FullListForRoom[index].approved == false ? "الحجز مرفوض " :
                                  "الحجز معتمد",

                                  maxLines: 2,

                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: FullListForRoom[index].rejected == false &&  FullListForRoom[index].approved == false ?Colors.amber:
                                      FullListForRoom[index].rejected == true &&  FullListForRoom[index].approved == false ? Colors.red :
                                      Colors.green,
                                      fontFamily: "Al-Jazeera-Arabic-Bold",
                                      fontSize: 15))
                            ],)


                            //  SizedBox(height: 5),
                            //3rd row


                          ],
                        )


                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                height: 20,
              ),
            ),
          ): loading == true ?
          Center(child: CircularProgressIndicator()):

          Center(
            child: Column(
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
                        getBookingFullListForRoom (roomid).then((result) async {
                          loading = true;
                          setState(() {
                            FullListForRoom = [];
                            loading = false;
                            FullListForRoom = result;
                          });

                        });
                      },child: Icon(Icons.refresh_sharp, color: Colors.black))
                ]

            ),
          ),







      ),
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


}

