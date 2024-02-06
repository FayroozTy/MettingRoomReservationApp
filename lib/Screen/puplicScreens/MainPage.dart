import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservation_app/Screen/BookingScreens/UsersScreen/bookingListForRoom/ui/BookingListPage.dart';
import 'package:reservation_app/Screen/BookingScreens/UsersScreen/reserveScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/user/BookingBriefList.dart';
import '../../Services/dio_client.dart';
import '../../Utli/Constatns.dart';
import 'loginPage.dart';


class mainPage extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  mainScreen(),
    );
  }
}


class mainScreen extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _mainScreen();
  }

}

class _mainScreen extends State<mainScreen> {

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  String userName = "";
  List<String> rooms = [""];
  List<String> Disrooms = [""];
  String selectval = "";
  int selectval_id = 1;
  late List<BookingBriefList> roomsList = [];
  StreamSubscription? internetconnection;
  bool isoffline = false;

  @override
  void dispose() {

    super.dispose();
    internetconnection!.cancel();
  }
  @override
  void initState()  {

    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
    }); // using this listiner, you can get the medium of connection as well.

    super.initState();
    getname();


    getBookingBriefList ().then((result) async {

    //  Navigator.of(context, rootNavigator: true).pop("Discard");

      setState(() {
        roomsList = result;
        print(roomsList);

        for (var item in roomsList.toSet().toList() ){
          rooms.add(item.roomName);
          Disrooms = rooms.toSet().toList();
        }

        selectval = Disrooms[0];
      });

    });
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
  getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name =  prefs.getString("loginName");
    print("name");
    setState(() {
      userName = name!;
      print(name);
    });

  }

  Widget errmsg(String text,bool show){
    //error message widget.
    if(show == true){
      //if error is true then show error message box
      return Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [

          Container(
            margin: EdgeInsets.only(right:6.00),
            child: Icon(Icons.info, color: Colors.white),
          ), // icon for error message

          Text(text, style: TextStyle(color: Colors.white, fontFamily: "Al-Jazeera-Arabic-Bold")),
          //show error message text
        ]),
      );
    }else{
      return Container();
      //if error is false, return empty container.
    }
  }

@override
Widget build(BuildContext context) {

   // showLoaderDialog(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () =>  PopshowDialogBox() ,
              ),
            title: Center(child: Text('الرئيسية', style: TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.white))),

            elevation: .1,
            backgroundColor: CustomColors.backgroundColor,
          ),
        body:
            ListView(
              children: [





                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  height: 150,
                  width:double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), //border corner radius
                    boxShadow:[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 7, // blur radius
                        offset: Offset(0, 2), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  child:Directionality(
                    textDirection: TextDirection.ltr,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text("  اهلا بك $userName ", style: TextStyle(
                                fontSize:17,fontFamily: "Al-Jazeera-Arabic-Regular"
                            ),),
                          ),
                          Center(
                            child: Text(" في تطبيق حجز القاعات", style: TextStyle(
                                fontSize:17,fontFamily: "Al-Jazeera-Arabic-Regular"
                            ),),
                          ),
                        ],

                      ),
                    ),
                  ),
                ),

           SizedBox(height: 10,),


                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      child: errmsg("لا يوجد اتصال بالانترنت حاليا", isoffline),
                      //to show internet connection message on isoffline = true.
                    ),

                    Center(
                      child: Text(" قائمة القاعات",style:
                      new TextStyle(fontFamily: "Al-Jazeera-Arabic-bold",fontSize: 15.0, color: Colors.black)),
                    ),

                    roomsList.length != 0 ?  ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: false,
                      padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 200),
                      itemCount: roomsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){


                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  bookingLisScreen(roomsList[index].meetingRoomId,roomsList[index].roomName)));



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
                            child: Column(

                              children: [
                                Center(
                                  child:  Text(roomsList[index].roomName,
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF686868),
                                          fontFamily: "Al-Jazeera-Arabic-Bold",
                                          fontSize: 15)),
                                ),


                                //  SizedBox(height: 5),
                                //3rd row


                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(
                        height: 20,
                      ),
                    ):
                    Center(child: CircularProgressIndicator()),

                  ]

                ),



          //     Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //
          //   children: [
          //
          //     InkWell(
          //       onTap: ()  {
          //
          //
          //         Navigator.push(context, MaterialPageRoute(builder: (_) => reserveScreen()));
          //
          //
          //       },
          //       child: Container(
          //         decoration: BoxDecoration(
          //
          //             color: CustomColors.backgroundColor,
          //
          //             borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
          //                 topRight: Radius.circular(10.0),
          //                 bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
          //         ),
          //
          //         width: 120,
          //         height: 100,
          //         child: Center(
          //           child: Text("احجز القاعة",style:
          //           new TextStyle(fontFamily: "Al-Jazeera-Arabic-bold",fontSize: 15.0, color: Colors.white)),
          //         ),
          //       ),
          //     ),
          //     Container(
          //       decoration: BoxDecoration(
          //
          //           color: CustomColors.backgroundColor,
          //
          //           borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
          //               topRight: Radius.circular(10.0),
          //               bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
          //       ),
          //
          //       width: 120,
          //       height: 100,
          //       child: Center(
          //         child: Text("عرض القاعات",style:
          //         new TextStyle(fontFamily: "Al-Jazeera-Arabic-bold",fontSize: 15.0, color: Colors.white)),
          //       ),
          //     ),
          //
          //     ]
          // )

                // Card(
                //     elevation: 1.0,
                //     margin: new EdgeInsets.only(right: 80,left: 80,top: 10),
                //     child: Container(
                //       decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
                //       child: new InkWell(
                //         onTap: () {
                //
                //
                //           Navigator.of(context).pushReplacement(
                //               MaterialPageRoute(builder: (BuildContext context) => reservePage()));
                //
                //         },
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.stretch,
                //           mainAxisSize: MainAxisSize.min,
                //           verticalDirection: VerticalDirection.down,
                //           children: <Widget>[
                //             SizedBox(height: 50.0),
                //             Center(
                //                 child: Icon(
                //                   Icons.calendar_month,
                //                   size: 40.0,
                //                   color: Colors.black,
                //                 )),
                //             SizedBox(height: 3.0),
                //             new Center(
                //               child: new Text("احجز القاعة",
                //                   style:
                //                   new TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.black)),
                //             )
                //           ],
                //         ),
                //       ),
                //     )),
                // Card(
                //     elevation: 1.0,
                //     margin: new EdgeInsets.only(right: 80,left: 80,top: 10),
                //     child: Container(
                //       decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
                //       child: new InkWell(
                //         onTap: () {
                //
                //
                //           Navigator.of(context).pushReplacement(
                //               MaterialPageRoute(builder: (BuildContext context) => reservePage()));
                //
                //         },
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.stretch,
                //           mainAxisSize: MainAxisSize.min,
                //           verticalDirection: VerticalDirection.down,
                //           children: <Widget>[
                //             SizedBox(height: 50.0),
                //             Center(
                //                 child: Icon(
                //                   Icons.list_alt,
                //                   size: 40.0,
                //                   color: Colors.black,
                //                 )),
                //             SizedBox(height: 3.0),
                //             new Center(
                //               child: new Text("عرض القاعات",
                //                   style:
                //                   new TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.black)),
                //             )
                //           ],
                //         ),
                //       ),
                //     )),

              ],
            )







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
                prefs.setString("isAdmin", "false");

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

