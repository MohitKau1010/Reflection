import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reflection/ui/home_screen.dart';
import 'package:reflection/ui/intro_screen.dart';

var routes = <String, WidgetBuilder>{
  "/start": (BuildContext context) => HomeScreen(),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///for orientatations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //String email = await PrefUtils.getString(PrefUtils.KEY_EMAIL);

  runApp(new MaterialApp(
      title: "Reflection",
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
      routes: routes));
}
