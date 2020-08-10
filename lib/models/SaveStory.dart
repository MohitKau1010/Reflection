// To parse this JSON data, do
//
//     final saveStory = saveStoryFromJson(jsonString);

import 'dart:convert';

SaveStory saveStoryFromJson(String str) => SaveStory.fromJson(json.decode(str));

String saveStoryToJson(SaveStory data) => json.encode(data.toJson());

class SaveStory {
  SaveStory({
    this.name,
    this.data,
  });

  String name;
  List<Datum> data;

  factory SaveStory.fromJson(Map<String, dynamic> json) => SaveStory(
    name: json["name"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {

  String questionType;
  String question;
  String answer;
  int order;

  Datum({
    this.questionType,
    this.question,
    this.answer,
    this.order,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    questionType: json["question_type"],
    question: json["question"],
    answer: json["answer"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "question_type": questionType,
    "question": question,
    "answer": answer,
    "order": order,
  };
}