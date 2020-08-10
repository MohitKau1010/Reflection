import 'package:flutter/material.dart';

class LoadingView {

  ///one option that is loading widget
  /*class LoadingSpinner extends StatelessWidget {
  LoadingSpinner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Center(
  child: CircularProgressIndicator(),
  );
  }
  }*/

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}