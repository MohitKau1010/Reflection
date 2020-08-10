import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:reflection/models/QuesListData.dart';
import 'package:reflection/models/SaveStory.dart';
import 'package:reflection/models/SaveStoryResponce.dart';
import 'package:reflection/models/StoreListData.dart';
import 'package:reflection/utils/constants.dart';
import 'package:reflection/utils/log.dart';
import 'package:reflection/utils/utils.dart';

class ApiManager{

  // ignore: missing_return
  Future<StoreListData> getStories() async {
    var client = http.Client();
    var storyList;
    try{
      Log.d(Constants.getStories); //>>>
      var responce = await client.get(Constants.getStories);
      Log.d(responce.body); //>>>
      if(responce.statusCode== 200){
        var jsonString = responce.body;
        var jsonMap = json.decode(jsonString);
        //var itemCount = jsonResponse['totalItems'];
        storyList = StoreListData.fromJson(jsonMap);
        return storyList;
      }
    }catch(Exception){
      return storyList;
    }
  }


  Future<SaveStoryResponse> saveStories(SaveStory saveStory) async {

    /// here http is >> "import 'package:http/http.dart' as http;"
    var responce =  await http.post(Constants.postStories,
      headers: {"Content-Type": "application/json"},
      body: saveStoryToJson(saveStory),
    );

    Log.d("saveStoryToJson is >> ${saveStoryToJson(saveStory)}");

    if(responce.statusCode==200){
      String responseString = responce.body;

      Utils.showToast("Your story is saved");
      return saveStoryResponseFromJson(responseString);
    }

    ////////
    /*Map data = {
      'apikey': '12345678901234567890'
    };
    //encode Map to JSON
    var body = json.encode(StoreListData.to);
    ////////
    var client = http.Client();
    var postStoriesList;
    try{
      Log.d(Constants.getQuestions); //>>>
      var responce = await client.post(Constants.getQuestions,
        headers: {"Content-Type": "application/json"},
          body: body,
      );
      Log.d(responce.body); //>>>


      if(responce.statusCode== 200){
        var jsonString = responce.body;
        var jsonMap = json.decode(jsonString);
        //var itemCount = jsonResponse['totalItems'];
        ///
        postStoriesList = StoreListData.fromJson(jsonMap);
        return postStoriesList;
      }
    }catch(Exception){
      return postStoriesList;
    }*/
  }

  // ignore: missing_return
  Future<QuesListData> getQuestions() async {
    var client = http.Client();
    var quesList;
    try{
      Log.d(Constants.getQuestions); //>>>
      var responce = await client.get(Constants.getQuestions);
      Log.d(responce.body); //>>>
      if(responce.statusCode== 200){
        var jsonString = responce.body;
        var jsonMap = json.decode(jsonString);
        //var itemCount = jsonResponse['totalItems'];
        ///
        quesList = QuesListData.fromJson(jsonMap);
        return quesList;
      }
    }catch(Exception){
      return quesList;
    }
  }

  /// ///////////////////////

  /*Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }*/
}