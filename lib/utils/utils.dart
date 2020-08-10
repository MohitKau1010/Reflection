import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        //timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white
    );

  }



  static Widget darkShadesOfContainer(MediaQueryData queryData) {
    return Container(
      margin: EdgeInsets.only(top: 0.0, right: 40.0, left: 40.0),
      padding: EdgeInsets.only(top: 21.0, left: 35.0, right: 35.0),
      width: queryData.size.width,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: hexToColor("#87cfea"),
          borderRadius: new BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
    );
  }

  static Widget lightShadeOfContainer(MediaQueryData queryData) {
    return Container(
      margin: EdgeInsets.only(top: 0.0, right: 60.0, left: 60.0),
      padding: EdgeInsets.only(top: 17.0, left: 35.0, right: 35.0),
      width: queryData.size.width,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: hexToColor("#c9e9f6"),
          borderRadius: new BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
    );
  }
}
