import 'package:flutter/material.dart';
import 'package:reflection/ui/question_screen.dart';
import 'package:reflection/ui/stories.dart';
import 'package:reflection/utils/navigater_helper.dart';
import 'package:reflection/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //region BackgroundColor
  Widget _background() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        decoration: BoxDecoration(
          color: Utils.hexToColor("#87cfea"),
        ),
      ),
    );
  }
  //endregion

  //region WelcomeText
  Widget _welcomeText(){
    return Text(
      "Welcome to Reflections",
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 24.0,),
    );
  }
  //endregion

  //region AppLogo
  Widget _appLogo(){
    return Opacity(
      opacity: 1.0,
      child: Padding(
        padding: EdgeInsets.only(left: 60.0, right: 60.0,top: 20.0,bottom: 20.0),
        child: Image.asset('assets/images/app_logo.png'),
      ),
    );
  }
  //endregion

  //region QuestionText
  Widget _questionText(){
    return Text(
      "How are you feeling today?",
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 22.0,),
    );
  }
  //endregion

  //region StartQuestions
  Widget _startQuestions(){
    return RaisedButton(
      elevation: 0.0,
      padding: EdgeInsets.only(left: 60.0, right: 60.0,top: 13.0,bottom: 13.0),
      color: Utils.hexToColor("#43b3e0"),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(50.0),
      ),
      onPressed: () {
        NavigationHelper.push(context, QuestionScreen());
      },
      child: Text('Questions', style: TextStyle(fontSize:17,color: Colors.white),),
    );
  }
  //endregion

  //region ShowStory
  Widget _showStory(){
    return RaisedButton(
      elevation: 0.0,
      padding: EdgeInsets.only(left: 70.0, right: 70.0,top: 13.0,bottom: 13.0),
      color: Utils.hexToColor("#c9e9f6"),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(50.0),
      ),
      onPressed: () {
        NavigationHelper.push(context, StoriesScreen());
      },
      child: Text('Stories', style: TextStyle(fontSize:17,color: Colors.black),),
    );
  }
  //endregion
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _welcomeText(),
                      _appLogo(),
                      _questionText(),
                      SizedBox(height: 73),
                      _startQuestions(),
                      SizedBox(height: 18,),
                      _showStory(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
