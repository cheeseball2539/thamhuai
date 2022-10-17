import 'package:flutter/material.dart';

class GlobalScaffold {
  GlobalKey keyScaffold;

  MyGlobals() {
    keyScaffold = GlobalKey();
  }

  GlobalKey get scaffold => keyScaffold;
}
