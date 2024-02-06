import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';



import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/user/data.dart';
import '../../Model/user/user_info.dart';
import '../../Services/dio_client.dart';
import '../../Utli/Constatns.dart';
import '../BookingScreens/AdminsScreen/AdminMainPage.dart';
import '../BookingScreens/AdminsScreen/BookingFullListPage.dart';
import 'MainPage.dart';



class loginPage extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  loginScreen(),
    );
  }
}


class loginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loginScreen();
  }

}

class _loginScreen extends State<loginScreen> {

  bool isDeviceConnected = false;
  bool isAlertSet = false;

  TextEditingController userName = TextEditingController();
  var _userNamecontroller = TextEditingController();
  var _Passwordcontroller = TextEditingController();
  String token= "";
  //final DioClient _dioClient = DioClient();
  bool loading = false;
  StreamSubscription? internetconnection;
  bool isoffline = false;

  @override
  void initState() {
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

  }

  @override
  void dispose() {

    super.dispose();
    internetconnection!.cancel();
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,



      body: loading ?

      SingleChildScrollView(
        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[



            Container(

                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[


                        Image.asset('images/booking.png'),

                      Center(child:
                      Text( textAlign: TextAlign.center, "تطبيق حجز القاعات" ,style: TextStyle(


                          fontSize: 24.0,color: CustomColors.backgroundColor,fontFamily: "Al-Jazeera-Arabic-Bold")
                      ),),
                    ],
                  ),
                )
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(

                // ignore: prefer_const_constructors
                  decoration: BoxDecoration(

                      color: Color(0xFFFFFFFF),
                      border: Border.all(
                        color: CustomColors.backgroundColor, //                   <--- border color
                        width: 1.0,
                      ),

                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
                  ),

                  child:   (

                      Container(

                        width:  MediaQuery
                            .of(context)
                            .size
                            .width - 30,
                        child:  Padding(
                          padding: EdgeInsets.all(25),

                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(


                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [


                                SizedBox(height: 15),




                                _TextFieldCustom( 1,"اسم المستخدم" , Icon(Icons.account_circle_outlined,),false),



                                SizedBox(height: 10),
                                _TextFieldCustom( 2,"كلمة المرور" , Icon(Icons.lock_outline),true),



                                SizedBox(height: 10),



                                SizedBox(
                                  height: 45,
                                  child:
                                  TextButton (


                                    onPressed: ()  async {
                                      fetch();


                                      //

                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: CustomColors.backgroundColor,

                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(20),

                                      ),
                                    )
                                    ,


                                    child: Center(
                                      child: Text(
                                        "تسجيل الدخول",
                                        style: TextStyle(color: Color(0xFFF5F5F5),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),




                              ],
                            ),

                          ),

                        ),


                      )

                  )
              ),
            ),
            Center(child: CircularProgressIndicator()),

          ],
        ),
      ):
      Padding(
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(


            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                          Container(
                          child: errmsg("لا يوجد اتصال بالانترنت حاليا", isoffline),
                          //to show internet connection message on isoffline = true.
                        ),


                        Image.asset('images/booking.png'),

                        Center(child:
                        Text( textAlign: TextAlign.center, "تطبيق حجز القاعات" ,style: TextStyle(


                            fontSize: 24.0,color: CustomColors.backgroundColor,fontFamily: "Al-Jazeera-Arabic-Bold")
                        ),),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(

                  // ignore: prefer_const_constructors
                    decoration: BoxDecoration(

                        color: Color(0xFFFFFFFF),
                        border: Border.all(
                          color: CustomColors.backgroundColor, //                   <--- border color
                          width: 1.0,
                        ),

                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
                    ),

                    child:   (

                        Container(

                          width:  MediaQuery
                              .of(context)
                              .size
                              .width - 30,
                          child:  Padding(
                            padding: EdgeInsets.all(25),

                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(


                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [


                                  SizedBox(height: 15),




                                  _TextFieldCustom( 1,"اسم المستخدم" , Icon(Icons.account_circle_outlined,),false),
                                   SizedBox(height: 10),
                                  _TextFieldCustom( 2,"كلمة المرور" , Icon(Icons.lock_outline),true),



                                  SizedBox(height: 10),



                                  SizedBox(
                                    height: 45,
                                    child:
                                    TextButton (


                                      onPressed: ()  async {

                                        fetch();


                                            },



                                      style: TextButton.styleFrom(
                                        backgroundColor: CustomColors.backgroundColor,

                                        shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(20),

                                        ),
                                      )
                                      ,


                                      child: Center(
                                        child: Text(
                                          "تسجيل الدخول",
                                          style: TextStyle(color: Color(0xFFF5F5F5),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),


                                ],
                              ),

                            ),

                          ),


                        )

                    )
                ),
              )


            ],
          ),
        ),
      ),


    );


  }
fetch() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
 String? t = prefs.getString("FCMtoken");
  print("ttt$t");
  setState(()  {
    loading = true;

  });


  UserInfo userInfo = UserInfo(
    username: _userNamecontroller.text,
    password: _Passwordcontroller.text,
    deviceOsTypeId: "100",


  );

  LoginPostRequest (userInfo).then((result) async {
    print("response: $result");



    if (result == null){
      showAlertDialog(context , "نبيه" , "خطا اسم المستخدم/كلمة المرور");
      setState(()  {
        loading = false;
      });
    }else{

      print(result?.status);
      if (result?.status == "Success"){

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("isLogin", "true");
        prefs.setString("loginName", result!.resultObject.Employee_Name);
        prefs.setInt("Employee_Citizen_ID", result!.resultObject.Employee_Citizen_ID);
        prefs.setString("username", _userNamecontroller.text);

        String name = _userNamecontroller.text;

        print(name.trim());


        LoginIsAdmin (name).then((result)  {

          int? Employee_Citizen_ID = prefs.getInt("Employee_Citizen_ID");
          String? token = prefs.getString("FCMtoken");

          AddDeviceToken (Employee_Citizen_ID!, token! ).then((AddDeviceTokenResp)  {

            if (result == "true") {

              prefs.setString("isAdmin", "true");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => AdminMainScreen()));

            }
            else{

              prefs.setString("isAdmin", "false");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => mainPage()));
            }

            setState(()  {
              loading = false;
            });


          });


        });

      }
      else{
        showAlertDialog(context , "نبيه" , "خطا اسم المستخدم/كلمة المرور");
        setState(()  {
          loading = false;
        });
      }
    }



  });


}

  Widget _TextFieldCustom(int flag  , String lableText , Icon icon , bool obscureText) {

    return    SizedBox(
      height: 45,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(


            obscureText: obscureText,



            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            onChanged: (_newValue) {

              setState(() {

                if (flag == 1) {


                  _userNamecontroller.value = TextEditingValue(
                    text: _newValue,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: _newValue.length),
                    ),
                  );
                }
                else{
                  _Passwordcontroller.value = TextEditingValue(
                    text: _newValue,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: _newValue.length),
                    ),
                  );
                }
              });

            },


            controller: flag == 1 ? _userNamecontroller: _Passwordcontroller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              hintText:lableText,
              hintStyle: TextStyle(
                  fontSize: 14.0,color: CustomColors.backgroundColor,fontFamily: "Al-Jazeera-Arabic-Regular"
              ),



              // label: Center(
              //   child: Text(lableText,style: TextStyle(
              //       fontSize: 14.0,color: Color(0xFF44a2a9),fontFamily: "Al-Jazeera-Arabic-Regular"
              //   ),),
              // ),


              suffixIcon: IconTheme(data: IconThemeData(
                  color: CustomColors.backgroundColor
              ), child: icon),

              //
              border: myinputborder(),
              enabledBorder: myinputborder(),
              focusedBorder: myfocusborder(),
            )
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



  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("موافق"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
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





}