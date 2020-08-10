import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:reflection/models/StoreListData.dart';
import 'package:reflection/services/api_manager.dart';
import 'package:reflection/ui/home_screen.dart';
import 'package:reflection/utils/navigater_helper.dart';
import 'package:reflection/utils/utils.dart';

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {

  Future<StoreListData> _storyList;

  final TextEditingController _answerController = TextEditingController(text: "");


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


  @override
  void initState() {
     _storyList = ApiManager().getStories();
    super.initState();
  }

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
                  SizedBox(
                    height: 30,
                  ),

                  ///top empty button layer..
                  _topButtonLayer(queryData),

                  Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(top: 20, right: 30.0, left: 30.0),
                        padding: EdgeInsets.all(20.0),
                        width: queryData.size.width,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Utils.hexToColor("#43b3e0"),
                            //Color.fromARGB(999, 67, 179, 224),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(29.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                            ),

                            ///input text for search stories..
                            _inputText(),

                            SizedBox(height: 30.0),
                            SizedBox(
                              height: 400.0,
                              child: FutureBuilder<StoreListData>(
                                future: _storyList,
                                builder: (context,snapshot) {
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                      itemCount: snapshot.data.stories.length,
                                        itemBuilder: (context,index){
                                        var storyDatas=snapshot.data.stories[index];
                                        var name = storyDatas.name;
                                        var date = new DateTime.fromMicrosecondsSinceEpoch(snapshot.data.stories[index].createdAt * 1000);

                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 15),
                                          child: Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              //fillColor: Colors.white,
                                              borderRadius: new BorderRadius.circular(9.0),
                                              border: Border.all(color: Colors.grey),
                                            ),
                                            child: ListTile(
                                              title: Align(
                                                  alignment: Alignment(-1.1, -0.6),
                                                  child: Text("$name", style: TextStyle(fontStyle: FontStyle.normal,color: Colors.grey))),
                                              trailing: Padding(
                                                  padding: EdgeInsets.only(left: 20, bottom: 10),
                                                  child: Text('${date.day}/${date.month}/${date.year}',
                                                      style: TextStyle(color: Colors.grey, fontSize: 9))),
                                              onTap: () {},
                                            ),
                                          ),
                                        );
                                    });
                                  }else{
                                    return Center(child: CircularProgressIndicator(),);
                                  }
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
                                  NavigationHelper.removeAll(context, HomeScreen());
                                },
                                child: Text(
                                  'Back',
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
                              const EdgeInsets.only(left: 40.0, right: 50.0),
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
                              Padding(
                                  padding: const EdgeInsets.only(top: 60.0),
                                  child: Text(
                                    "Sorted by",
                                    style: TextStyle(fontSize: 10),
                                  ))
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
}
