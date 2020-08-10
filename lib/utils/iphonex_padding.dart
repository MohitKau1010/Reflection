import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class IPhoneXPadding extends Container {
  final Widget child;

  IPhoneXPadding({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    if (!_isIPhoneX(mediaQueryData)) {
      // fallback for all non iPhone X
      return child;
    }

    var homeIndicatorHeight =
        // TODO verify exact values
        mediaQueryData.orientation == Orientation.portrait ? 22.0 : 20.0;

    return Container(
      padding: EdgeInsets.only(bottom: homeIndicatorHeight),
      child: child,
    );
  }

  bool _isIPhoneX(MediaQueryData mediaQuery) {
    if (Platform.isIOS) {
      var size = mediaQuery.size;
      if (size.height >= 812.0 || size.width >= 812.0) {
        return true;
      }
    }
    return false;
  }
}
