import 'package:flutter/material.dart';
import 'package:reflection/models/QuesListData.dart';
import 'package:reflection/styles/color.dart';
import 'package:reflection/utils/answerCallBack.dart';
import 'package:reflection/utils/utils.dart';

class QuestionType extends StatefulWidget {
  final Question quesData;

  /// >>> question obeject;
  final int indexPosition;
  final VoidCallback onNextClick;

  //final VoidCallback answer();
  ///new for callback
  final AnswerCallback mAnswerCallback;

  QuestionType({Key key,
    @required this.quesData,
    @required this.indexPosition,
    this.mAnswerCallback,
    this.onNextClick,
  }) : super(key: key);

  @override
  _QuestionTypeState createState() => _QuestionTypeState();
}

class _QuestionTypeState extends State<QuestionType> {

  bool selectedAnswer;
  final TextEditingController _answerController = TextEditingController(text: "");
  final FocusNode _inptFoucsNode = FocusNode();


  Widget _nextButton() {
    return Align(
      alignment: Alignment.center,
      child: RaisedButton(
        elevation: 0.0,
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 9.0, bottom: 13.0),
        color: Utils.hexToColor("#c9e9f6"),
        //Color.fromARGB(999, 201, 233, 246),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(40.0),
        ),
        onPressed: () {
          if(widget.quesData.question_type==0) {
            _sendAnswerText();
            widget.onNextClick();
          } else {
            widget.onNextClick();
          }
          ///NavigationHelper.push(context, QuestionsThree());
        },
        child: Text(
          (widget.indexPosition == 5) ? 'Finish' : 'Next',
          style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _optionButton(MediaQueryData queryData, String answerText) {

    ///when
    (widget.quesData.answer == answerText) ? selectedAnswer=true : selectedAnswer=false;

    return SizedBox(
      width: queryData.size.width - 2 / 10,
      height: 40.0,
      child: RaisedButton(
          padding: EdgeInsets.only(left: 19.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0), side: BorderSide(color: Colors.grey)),
          onPressed: () {
            var questionModel = widget.quesData;
            questionModel.answer = answerText;
            widget.mAnswerCallback.addAnswer(
                widget.indexPosition, questionModel); //(_answerController.text);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answerText,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              maxLines: 2,
            ),
          ),
          color: (selectedAnswer) ? hexToColor("#c9e9f6") : Colors.white //hexToColor('#c9e9f6'),
      ),
    );
  }

  //region InputTextField
  Widget _inputTextField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      controller: _answerController,
      focusNode: _inptFoucsNode,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _inptFoucsNode);
      },
      maxLines: 8,
      minLines: 8,
      autofocus: false,
      textInputAction: TextInputAction.done,
      decoration: new InputDecoration(
        filled: true,
        isDense: true,
        hintText: "Answer",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5.0),
          borderSide: new BorderSide(),
        ),
      ),
      validator: (val) {
        if (val.isEmpty) {
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

  //region questionType
  Widget _custumUI(int questionType, MediaQueryData queryData) {


    switch (questionType) {
      case 0:
        {
          ///input field
          return Container(
            height: 320,
            width: queryData.size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    '${widget.quesData.question}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  ///input text filed
                  _inputTextField(),
                ],
              ),
            ),
          );
        }
        break;

      case 1:
        {
          ///input field
          return Container(
            height: 320,
            width: queryData.size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    '${widget.quesData.question}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  ///text input 1
                  _optionButton(queryData, '${widget.quesData.option_one}',),

                  SizedBox(
                    height: 20.0,
                  ),

                  ///text input 2
                  _optionButton(queryData, '${widget.quesData.option_two}',),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///Text input 3
                  _optionButton(queryData, '${widget.quesData.option_three}',),

                  SizedBox(
                    height: 20.0,
                  ),

                  ///Text input 4
                  _optionButton(queryData, '${widget.quesData.option_four}',),
                ],
              ),
            ),
          );
        }
        break;

      case 2:
        {
          ///three option buttons
          return Container(
            height: 320,
            width: queryData.size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    '${widget.quesData.question}',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  ///text input 1
                  _optionButton(queryData, '${widget.quesData.option_one}',),

                  SizedBox(
                    height: 20.0,
                  ),

                  ///text input 2
                  _optionButton(queryData, '${widget.quesData.option_two}',),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///Text input 3
                  _optionButton(queryData, '${widget.quesData.option_three}',),
                ],
              ),
            ),
          );
        }
        break;

      case 3:
        {
          ///two input buttons
          return Container(
            height: 320,
            width: queryData.size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    '${widget.quesData.question}',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  ///text input 1
                  _optionButton(queryData, '${widget.quesData.option_one}',),

                  SizedBox(
                    height: 20.0,
                  ),

                  ///Text input 3
                  _optionButton(queryData, '${widget.quesData.option_two}',),
                ],
              ),
            ),
          );
        }
        break;
      default:
        {
          /// empty question
          return Container(
            height: 320,
          );
        }
        break;
    }
  }

//endregion

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              /// top margin
              SizedBox(
                height: 30,
              ),

              Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 17, right: 20.0, left: 20.0),
                    padding: EdgeInsets.all(20.0),
                    width: queryData.size.width,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Utils.hexToColor("#43b3e0"),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),

                        _custumUI(widget.quesData.question_type, queryData),

                        SizedBox(
                          height: 30,
                        ),

                        ///next button..
                        _nextButton(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, bottom: 40.0),
                      child: Image(
                        width: 100,
                        height: 80,
                        image: AssetImage('assets/images/flutter_logo_v2.png'),
                      ),
                    ),
                  )
                ],
              ),
              Utils.darkShadesOfContainer(queryData),
              Utils.lightShadeOfContainer(queryData),
              //SizedBox(height: 50,),
            ],
          ),
        ],
      ),
    );
  }

  void _fieldFocusChange(BuildContext context, FocusNode inptFoucsNode) {
    inptFoucsNode.unfocus();
    /// if questionType zero then take input and se
    var questionModel = widget.quesData;
    questionModel.answer = _answerController.text;
    widget.mAnswerCallback.addAnswer(widget.indexPosition, questionModel);
  }

  void _sendAnswerText(){
    /// if questionType zero then take input and se
    var questionModel = widget.quesData;
    questionModel.answer = _answerController.text;
    widget.mAnswerCallback.addAnswer(widget.indexPosition, questionModel);

  }

}
