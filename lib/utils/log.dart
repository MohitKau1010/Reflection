
import 'constants.dart';

class Log {
  static void d(String str) {
    if (Constants.BUILD_CONFIG == Enviroment.DEV ||
        Constants.BUILD_CONFIG == Enviroment.STAGING) {
      print("\n\n\n>>>" + str.toString());
    }
  }
}
