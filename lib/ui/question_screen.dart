import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:reflection/models/QuesListData.dart';
import 'package:reflection/services/api_manager.dart';
import 'package:reflection/ui/question_type.dart';
import 'package:reflection/ui/story_detail_screen.dart';
import 'package:reflection/utils/answerCallBack.dart';
import 'package:reflection/utils/navigater_helper.dart';
import 'package:reflection/utils/utils.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> implements AnswerCallback {
  Future<QuesListData> _quesList;
  List<Question> _aswerList;

  int currentIndexPage;
  int pageLength;

  bool four, five;

  ///control page view
  PageController pageController1 = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    _quesList = ApiManager().getQuestions();
    currentIndexPage = 0;
    pageController1 = PageController()
      ..addListener(() {
        _listener();
      });
    pageLength = 5;
    //four=false;
    //five=false;
    super.initState();
  }

  _listener() {
    if (pageController1.position.userScrollDirection == ScrollDirection.reverse) {

      //swip right
      (currentIndexPage == 3) ? four = true : four = false;
      // ignore: unnecessary_statements
      (currentIndexPage == 4) ? five = true : null;
      (currentIndexPage == 0) ? five = false : five = false;
    } else {
      //swip left
      // ignore: unnecessary_statements
      (currentIndexPage == 4) ? five = true : null;
    }
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  //region StoryBtn
  Widget _storyButton() {
    return RaisedButton(
      elevation: 0.0,
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 13.0, bottom: 13.0),
      color: Color.fromARGB(999, 201, 233, 246),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      onPressed: () {
        NavigationHelper.push(context, StoryDetailScreen(_aswerList));
      },
      child: Text(
        'Story',
        style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

  //endregion

  //region QuestionBtn
  Widget _questionButton() {
    return RaisedButton(
      elevation: 4.0,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 13.0, bottom: 13.0),
      color: Utils.hexToColor("#43b3e0"),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      onPressed: () {
        ///NavigationHelper.push(context, Questions());
      },
      child: Text(
        'Questions',
        style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /// top margin
                  SizedBox(
                    height: 30,
                  ),

                  ///Buttons row..
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _questionButton(),
                        Padding(
                          padding: EdgeInsets.only(right: 50.0),
                        ),
                        _storyButton(),
                      ]),

                  ///container padding
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, bottom: 20.0, left: 40.0, right: 20.0),
                    child: Text(
                      'Question ${currentIndexPage + 1}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),

                  Container(
                    height: 600,
                    child: FutureBuilder<QuesListData>(
                      future: _quesList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var quesData = snapshot.data.questions;
                          _aswerList = snapshot.data.questions;
                          return PageView(
                              //scrollDirection: Axis.vertical,
                              pageSnapping: true,
                              //physics: NeverScrollableScrollPhysics(), //ClampingScrollPhysics() , (four)? NeverScrollableScrollPhysics() :
                              controller: pageController1,
                              children: <Widget>[
                                QuestionType(
                                  quesData: quesData[currentIndexPage],
                                  indexPosition: currentIndexPage,
                                  mAnswerCallback: this,
                                  onNextClick: () {
                                    setState(() {
                                      currentIndexPage = 1;
                                    });
                                    pageController1.jumpToPage(1);
                                  },
                                ),
                                QuestionType(
                                  quesData: quesData[currentIndexPage],
                                  indexPosition: currentIndexPage,
                                  mAnswerCallback: this,
                                  onNextClick: () {
                                    setState(() {
                                      currentIndexPage = 2;
                                    });
                                    pageController1.jumpToPage(2);
                                  },
                                ),
                                QuestionType(
                                  quesData: quesData[currentIndexPage],
                                  indexPosition: currentIndexPage,
                                  onNextClick: () {
                                    setState(() {
                                      currentIndexPage = 3;
                                    });
                                    pageController1.jumpToPage(3);
                                  },
                                  mAnswerCallback: this,
                                ),
                                QuestionType(
                                  quesData: quesData[currentIndexPage],
                                  indexPosition: currentIndexPage,
                                  onNextClick: () {
                                    setState(() {
                                      currentIndexPage = 4;
                                      four = true;
                                    });
                                    pageController1.jumpToPage(4);
                                  },
                                  mAnswerCallback: this,
                                ),
                                QuestionType(
                                  quesData: quesData[currentIndexPage],
                                  indexPosition: currentIndexPage,
                                  onNextClick: () {
                                    setState(() {
                                      //PrefUtils.setBoolValue(PrefUtils.KEY_FIVE,true);
                                      currentIndexPage = 4;
                                      five = true;
                                    });

                                    /// move to story screen then this dialog
                                    NavigationHelper.push(context, StoryDetailScreen(_aswerList));
                                  },
                                  mAnswerCallback: this,
                                ),
                              ],
                              onPageChanged: (value) {
                                // ignore: unnecessary_statements
                                (four && currentIndexPage == 0)
                                    ? pageController1.jumpToPage(1)
                                    : null;
                                // ignore: unnecessary_statements
                                (five && currentIndexPage == 1)
                                    ? pageController1.jumpToPage(2)
                                    : null; //Utils.showToast("five is $five")
                                setState(() {
                                  currentIndexPage = value;
                                });
                                // ignore: unnecessary_statements
                                (value == 0 && four) ? pageController1.jumpToPage(1) : null;
                                // ignore: unnecessary_statements
                                (value == 1 && five) ? pageController1.jumpToPage(2) : null;
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void addAnswer(int position,Question questionModel) {
    //Utils.showToast(questionModel.answer);
    setState(() {
      _aswerList.removeAt(position);
      _aswerList.insert(position, questionModel);
    });
  }
}
