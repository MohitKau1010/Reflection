import 'package:flutter/material.dart';
import 'package:reflection/utils/dialog_utils.dart';
import 'package:reflection/utils/dimen.dart';
import 'package:reflection/utils/iphonex_padding.dart';
import 'package:reflection/utils/loading_view.dart';
import 'package:reflection/utils/pref_utils.dart';


abstract class BaseState<T> extends State with AutomaticKeepAliveClientMixin {
  String _isTitle = "";
  //LoadingBloc _loadingBloc;
  ///loading
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    _isTitle = getTitle();
    //_loadingBloc = LoadingBloc();
  }

  String getTitle();

  Widget bodyView();

  void _showLoading(bool isShow) {
    //_loadingBloc.showLoading(isShow);
    if(isShow){
      LoadingView.showLoadingDialog(context, _keyLoader);
    }else{
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
    }
    //invoking login
    //await serivce.login(user.uid);
    //Navigator.pushReplacementNamed(context, "/home");
    //////
  }

  _moveToLoginScreen() {
    //final bloc = LoginBloc();
    /*Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              BlocProvider<LoginBloc>(bloc: bloc, child: LoginScreen()),
        ),
        ModalRoute.withName('/'));*/
  }

  void requestApi(Future request, {bool isLoading = true, bool finishError = false}) {
    _showLoading(isLoading);
    request.then((_) {
      _showLoading(false);
    }).catchError((error) {
      _showLoading(false);
      String errorMessage = error.toString();
      if (errorMessage.contains("401")) {
        PrefUtils.remove(PrefUtils.KEY_TOKEN);
        _moveToLoginScreen();
        DialogUtils.showOkDialog(context, "session expired", isFinish: finishError);
        return;
      }
      DialogUtils.showOkDialog(context, errorMessage, isFinish: finishError);
    });
  }

  Widget loadingView(bool isShow) {
    if (isShow) {
      return Container(
        color: Colors.white70,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget errorView(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }

  Widget getAppbar(String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: new Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: Dimen.textActionbar),
      ),
    );
  }

  Widget getFloatingActionButton() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return IPhoneXPadding(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.0), // here the desired height
            child: getAppbar(_isTitle)),
        body: Container(
          child: Stack(
            children: <Widget>[
              //body view
              bodyView(),

              //loading
              /*StreamBuilder<bool>(
                  stream: _loadingBloc.loadingStrem,
                  initialData: false,
                  builder: (context, snapshot) {
                    return loadingView(snapshot.data);
                  })*/
            ],
          ),
        ),
        floatingActionButton: getFloatingActionButton(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
