
import 'package:flutter/material.dart';

//String BaseURL = "http://192.168.0.170:5146/";
String BaseURL = "http://83.244.112.170:5146/";


//String Token_BaseURL = "http://192.168.0.170:5135";
String Token_BaseURL = "http://83.244.112.170:5135";


String ErrorMsg = "";
String LoginType = 'puplic';
class CustomColors {
  static const Color backgroundColor = Colors.blueGrey;
  static var index = 0;

}


showAlertDialog(BuildContext context , String title , String content) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("موافق"),
    onPressed: () {
      Navigator.pop(context);
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

sAlertDialog(BuildContext context , String title , String content) {



  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(child: Text(title,style: TextStyle(
        color: Colors.black,
        fontFamily: "Al-Jazeera-Arabic-Bold",
        fontSize: 15),)),
    content: Text(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      content, style: TextStyle(

        color: Colors.black,
        fontFamily: "Al-Jazeera-Arabic-Regular",
        fontSize: 16),),
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