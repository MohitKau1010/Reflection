// To parse this JSON data, do
//
//     final saveStory = saveStoryFromJson(jsonString);

import 'dart:convert';

SaveStoryResponse saveStoryResponseFromJson(String str) => SaveStoryResponse.fromJson(json.decode(str));

String saveStoryResponseToJson(SaveStoryResponse data) => json.encode(data.toJson());

class SaveStoryResponse {
  SaveStoryResponse({
    this.status,
    this.success,
    this.message,
  });

  int status;
  bool success;
  String message;

  factory SaveStoryResponse.fromJson(Map<String, dynamic> json) => SaveStoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
  };
}
