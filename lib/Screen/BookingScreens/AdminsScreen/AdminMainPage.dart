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
import 'BookingFullListPage.dart';
import 'Orders/ui/OrdersPage.dart';
import 'RejectedListPage.dart';








class AdminMainScreen extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AdminMainScreen();
  }

}

class _AdminMainScreen extends State<AdminMainScreen> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  void initState()  {
    super.initState();


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



  Widget build(BuildContext context) {

    // showLoaderDialog(context);
    return WillPopScope(
      onWillPop: _onWillPop ,
      child: Scaffold(

          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () =>  PopshowDialogBox() ,
            ),


            title: Center(child: Text("الرئيسية", style: TextStyle(fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 18.0, color: Colors.white))),




            backgroundColor: CustomColors.backgroundColor,


          ),

          body:

                ListView.separated(


                  shrinkWrap: true,
                  reverse: false,
                  padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 100),
                  itemCount:3,
                  itemBuilder: (BuildContext context, int index) {
                    return
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
                          index == 0 ?  InkWell(
                            onTap: (){

                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  BookingListScreen()));

                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: IconButton(
                                      onPressed: (){},
                                      icon:  Icon(Icons.check_circle, color: Colors.green,size: 50,),
                                    ),
                                  ),


                                  Column(

                                    children: [

                                      Text("الحجوزات المعتمدة",
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontFamily: "Al-Jazeera-Arabic-Bold",
                                              fontSize: 18)),
                                      SizedBox(height: 10,),


                                    ],
                                    mainAxisAlignment: MainAxisAlignment.end,

                                  ),

                                ],
                              ),
                          ):
                          index == 1 ? InkWell(
                            onTap: (){

                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  RejectedListPage()));

                            },

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: (){},
                                  icon:  Icon(Icons.cancel, color: Colors.red,size: 50,),
                                ),


                                Column(

                                  children: [

                                    Text("الحجوزات المرفوضة ",
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontFamily: "Al-Jazeera-Arabic-Bold",
                                            fontSize: 18)),
                                    SizedBox(height: 10,),


                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,

                                ),

                              ],
                            ),
                          ) :



                          InkWell(
                            onTap: (){

                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  OrdersListScreen()));

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: (){},
                                  icon:  Icon(Icons.list, color: Colors.amber,size: 50,),
                                ),


                                Column(

                                  children: [

                                    Text("الطلبات",
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontFamily: "Al-Jazeera-Arabic-Bold",
                                            fontSize: 18)),
                                    SizedBox(height: 10,),


                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,

                                ),

                              ],
                            ),
                          ),


                            //  SizedBox(height: 5),
                            //3rd row


                          ],
                        ),
                      );
                  },
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(
                    height: 20,
                  ),
                )

               ,
              ),
    );











  }








}

