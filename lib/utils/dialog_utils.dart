import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reflection/styles/color.dart';
import 'package:reflection/utils/dialogCallBack.dart';
import 'package:reflection/utils/log.dart';
import 'package:reflection/utils/navigater_helper.dart';

/// help callback
typedef void ConfirmCallback(bool isAccep);


class DialogUtils {
  ///new for callback
  AlertDialogCallback mAlertDialogCallback;
  DialogUtils([this.mAlertDialogCallback]);

  static showOkDialog(BuildContext context, String message,
      {String title = "Error", bool isFinish = false}) {
    message = message.replaceAll("Exception: ", "");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                message,
                style: TextStyle(fontSize: 12),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (isFinish) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              )
            ],
          );
        });
  }

  static showConfirmDialog(BuildContext context, String message, ConfirmCallback callback,
      {String title}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title ?? "this dummy question",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                message,
                style: TextStyle(fontSize: 12),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  callback(false);
                  Navigator.pop(context);
                },
                child: Text(
                  'cancel',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  callback(true);
                  Navigator.pop(context);
                },
                child: Text(
                  'ok',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                  ),
                ),
              )
            ],
          );
        });
  }

  saveDialog(BuildContext context,bool isSaved,bool isQuestion) {
    showDialog(
        context: context,
        builder: (BuildContext context) {

          final TextEditingController _answerController = TextEditingController(text: "");
          bool isSave= isSaved;
          return Dialog(
            backgroundColor: hexToColor('#43b3e0'),//43b3e0
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
            child: Container(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "What do you want to \ndo with your Story?",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 23),
                    ),
                    /*TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'What do you want to \ndo with your Story?'),
                          //hintText: 'What do you want to \ndo with your Story?'),
                    ),*/
                    SizedBox(height: 15,),

                    (isSave)?  SizedBox(
                        width: 210.0,
                        height: 30.0,
                        child:TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _answerController,
                      maxLines: 1,
                      minLines: 1,
                      autofocus: false,
                      decoration: new InputDecoration(
                        filled: true,
                        isDense: true,
                        //hintText: "text",
                        labelText: "text",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Story is empty";
                        } else {
                          return null;
                        }
                      },
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )) :  Container(),

                    SizedBox(height: 15,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          height: 30.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                //side: BorderSide(color: Colors.red)
                            ),
                            onPressed: () {
                              /// show edit text now
                              Navigator.of(context).pop();

                              /// isQuestion is for identify is from queustion or finish buttun...
                              //(isQuestion) ?
                              mAlertDialogCallback.onPositive(_answerController.text);
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: hexToColor('#c9e9f6'),
                          ),
                        ),
                        SizedBox(width: 15,),
                        SizedBox(
                          width: 100.0,
                          height: 30.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              //side: BorderSide(color: Colors.red)
                            ),
                            onPressed: () {
                              NavigationHelper.pop(context);
                              mAlertDialogCallback.onNegative();
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: hexToColor('#c9e9f6'),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }

}
