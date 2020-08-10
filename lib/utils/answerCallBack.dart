import 'package:reflection/models/QuesListData.dart';

abstract class AnswerCallback {
  void addAnswer(int position,Question answer);
  //void onNegative();
}