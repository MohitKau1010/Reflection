import 'package:connectivity/connectivity.dart';

/// help callback
typedef void NetworkCallback(bool isConnected);

class NetworkUtils {

  var subscription;

  initState() {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("Connection Status has Changed");
    });
  }

  dispose() {
    subscription.cancel();
  }

  var connectivityResult =  (Connectivity().checkConnectivity()); //await

  /*if(connectivityResult == ConnectivityResult.mobile) {
  print("Connected to Mobile Network");
  } else if (connectivityResult == ConnectivityResult.wifi) {
  print("Connected to WiFi");
  } else {
  print("Unable to connect. Please Check Internet Connection");
  }*/

}