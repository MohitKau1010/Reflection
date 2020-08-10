

import 'dart:convert';

class QuesListData {
    String message;
    List<Question> questions;
    int statusCode;

    QuesListData({this.message, this.questions, this.statusCode});

    factory QuesListData.fromJson(Map<String, dynamic> json) {
        return QuesListData(
            message: json['message'], 
            questions: json['questions'] != null ? (json['questions'] as List).map((i) => Question.fromJson(i)).toList() : null, 
            statusCode: json['statusCode'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['statusCode'] = this.statusCode;
        if (this.questions != null) {
            data['questions'] = this.questions.map((v) => v.toJson()).toList();
        }
        return data;
    }

    /////////////////////////////////////////
    static String encodeQuestion(List<Question> ques) => json.encode(ques
        .map<Map<String, dynamic>>((quest) => Question.toMap(quest))
        .toList(),
    );

    static List<Question> decodeQuestion(String musics) =>
        (json.decode(musics) as List<dynamic>)
            .map<Question>((item) => Question.fromJson(item))
            .toList();
   /////////////////////////////////////////
/*static Map<String, dynamic> listToMap(List<Question> list) => {
        '__v': questions.__v,
        '_id': questions._id,
        'answer': question.answer,
        'option_four': question.option_four,
        'option_one': question.option_one,
        'option_three': question.option_three,
        'option_two': question.option_two,
        'order': question.order,
        'question': question.question,
        'question_type': question.question_type,
    };*/

}

class Question {
    int __v;
    String _id;
    String answer;
    String option_four;
    String option_one;
    String option_three;
    String option_two;
    int order;
    String question;
    int question_type;

    Question({/*this.__v, this._id,*/ this.answer, this.option_four, this.option_one, this.option_three, this.option_two, this.order, this.question, this.question_type});

    factory Question.fromJson(Map<String, dynamic> json) {
        return Question(
            //__v: json['__v'],
            //_id: json['_id'],
            answer: json['answer'],
            option_four: json['option_four'],
            option_one: json['option_one'],
            option_three: json['option_three'],
            option_two: json['option_two'],
            order: json['order'],
            question: json['question'],
            question_type: json['question_type'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['__v'] = this.__v;
        data['_id'] = this._id;
        data['answer'] = this.answer;
        data['option_four'] = this.option_four;
        data['option_one'] = this.option_one;
        data['option_three'] = this.option_three;
        data['option_two'] = this.option_two;
        data['order'] = this.order;
        data['question'] = this.question;
        data['question_type'] = this.question_type;
        return data;
    }



    ///converting object to map
    static Map<String, dynamic> toMap(Question question) => {
        '__v': question.__v,
        '_id': question._id,
        'answer': question.answer,
        'option_four': question.option_four,
        'option_one': question.option_one,
        'option_three': question.option_three,
        'option_two': question.option_two,
        'order': question.order,
        'question': question.question,
        'question_type': question.question_type,
    };


}