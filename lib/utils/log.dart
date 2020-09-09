
import 'package:flutter/foundation.dart';

import 'constants.dart';

class Log {
  static void d(String str) {
    if (Constants.BUILD_CONFIG == Enviroment.DEV ||
        Constants.BUILD_CONFIG == Enviroment.STAGING) {
      debugPrint("\n\n\n>>>" + str.toString(), wrapWidth: 1024);
      
    }
  }
}
