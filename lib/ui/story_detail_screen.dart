import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reflection/models/QuesListData.dart';
import 'package:reflection/models/SaveStory.dart';
import 'package:reflection/services/api_manager.dart';
import 'package:reflection/ui/home_screen.dart';
import 'package:reflection/ui/question_screen.dart';
import 'package:reflection/ui/stories.dart';
import 'package:reflection/utils/dialogCallBack.dart';
import 'package:reflection/utils/dialog_utils.dart';
import 'package:reflection/utils/log.dart';
import 'package:reflection/utils/navigater_helper.dart';
import 'package:reflection/utils/utils.dart';

class StoryDetailScreen extends StatefulWidget {
  final List<Question> listQuestion;

  const StoryDetailScreen(this.listQuestion);

  @override
  _StoryDetailScreenState createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> implements AlertDialogCallback {

  final TextEditingController _answerController = TextEditingController(text: "");

  //region ListRow
  Widget _listTile(Question question) {
    return Container(
      //height: 25,
      child: Text("${question.question} User Answer :${question.answer} \n",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }

  //endregion

  //region InputText
  Widget _inputText() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      controller: _answerController,
      maxLines: 1,
      minLines: 1,
      autofocus: false,
      decoration: new InputDecoration(
        filled: true,
        isDense: true,
        hintText: "Search Stories",
        hintStyle: TextStyle(color: Colors.grey),
        //labelText: "Answer",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(9.0),
          borderSide: new BorderSide(),
        ),
      ),
      validator: (val) {
        if (val.length == 0) {
          return "Answer is not empty";
        } else {
          return null;
        }
      },
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }

  //endregion

  //region TopbarButton
  Widget _topButtonLayer(MediaQueryData queryData) {
    return Container(
      width: queryData.size.width,
      height: 60,
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0, bottom: 13.0),
      child: RaisedButton(
        elevation: 0.0,
        padding:
        EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 13.0),
        color: Utils.hexToColor('#c9e9f6'),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(9.0),
        ),
        onPressed: () {
          ///NavigationHelper.push(context, Questions());
        },
      ),
    );
  }

  //endregion

  //region StoryBtn
  Widget _storyButton() {
    return RaisedButton(
      elevation: 0.0,
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 13.0, bottom: 13.0),
      color: Utils.hexToColor("#43b3e0"),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      onPressed: () {
        NavigationHelper.push(context, StoriesScreen());
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
      color: Color.fromARGB(999, 201, 233, 246),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      onPressed: () {
        DialogUtils(this).saveDialog(context, false, true);
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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

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
                    height: 40,
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

                  Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[

                      Container(
                        margin:
                        EdgeInsets.only(top: 60, right: 30.0, left: 30.0),
                        padding: EdgeInsets.all(20.0),
                        width: queryData.size.width,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Utils.hexToColor("#43b3e0"),
                            borderRadius:
                            new BorderRadius.all(Radius.circular(29.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                            ),

                            SizedBox(height: 30.0),
                            SizedBox(
                              height: 400.0,
                              child: ListView.builder(
                                itemCount: widget.listQuestion.length,
                                itemBuilder: (context, index) {
                                  return _listTile(widget.listQuestion[index]);
                                },
                              ),
                            ),

                            SizedBox(
                              height: 20.0,
                            ),

                            ///Back button..
                            //region BackButton
                            Align(
                              alignment: Alignment.center,
                              child: RaisedButton(
                                elevation: 0.0,
                                padding: EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    top: 13.0,
                                    bottom: 13.0),
                                color: Utils.hexToColor("#c9e9f6"),
                                //Color//.fromARGB(999, 201, 233, 246),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(22.0),
                                ),
                                onPressed: () {
                                  DialogUtils(this).saveDialog(context, false, true);
                                  //NavigationHelper.removeAll(context, HomeScreen());
                                },
                                child: Text(
                                  'Finish',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black),
                                ),
                              ),
                            )
                            //endregion
                          ],
                        ),
                      ),

                      ///for top app logo (overview)..
                      //region ApplogoOverlay
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 40.0, right: 50.0, top: 30.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image(
                                width: 100,
                                height: 80,
                                image: AssetImage(
                                    'assets/images/flutter_logo_v2.png'),
                              ),
                              /*Padding(
                                  padding: const EdgeInsets.only(top: 60.0),
                                  child: Text(
                                    "Sorted by",
                                    style: TextStyle(fontSize: 10),
                                  ))*/
                            ],
                          ),
                        ),
                      ),
                      //endregion
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
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
  void onNegative() {
    Navigator.of(context).pop();

    ///if dismiss then goto questions
    NavigationHelper.push(context, QuestionScreen());
  }

  @override
  void onPositive(String text) {
    // do your logic here
    Log.d(text);

    ///if we save btn then hit api then goto Home screen.
    if (text.isEmpty) {
      DialogUtils(this).saveDialog(context, true, false);
    } else {
      List<Question> question = widget.listQuestion;

      //storyData
      List<Datum> storyData;

      storyData = <Datum>[
        for(int i=0; i<question.length; i++)
          Datum(questionType: question[i].question_type.toString(),question: question[i].question, answer: question[i].answer)
      ];

    var saveStoryD = SaveStory(name: text,data: storyData);
    Log.d("saveStoryD list is >> $saveStoryD");

    ///hit save api
    ApiManager().saveStories(saveStoryD);
    //var response =
    //Utils.showToast(response.toString());

    NavigationHelper.push(context, HomeScreen());
    }
  }
}
