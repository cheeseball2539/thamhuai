import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:thamhuai/home.dart';
import 'package:thamhuai/utility/tool_utility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ToolUtility.appName,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(ToolUtility.colorMainHax, ToolUtility.colorMainPrimarySwatch),
      ),
      builder: BotToastInit(),
      home: Home(),
    );
  }
}