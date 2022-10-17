import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:thamhuai/utility/custom_input.dart';
import 'package:thamhuai/utility/futurebuilder_loading.dart';
import 'package:thamhuai/utility/global_scaffold.dart';
import 'package:thamhuai/utility/tool_utility.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<bool> callData;
  ScreenshotController screenshotController = ScreenshotController();
  var controllerDate = TextEditingController();
  var controllerNumber2 = TextEditingController();
  var controllerNumber3 = TextEditingController();
  var result2 = "";
  var result3 = "";
  var date = "";

  @override
  void initState() {
    super.initState();
    ToolUtility.requestPermissions();
    callData = callDataMain();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<bool> callDataMain() async {
    await main();
    return true;
  }

  main() async {
    ToolUtility.loading(true);
    ToolUtility.loading(false);
  }

  calculate() {
    var number2 = controllerNumber2.text.trim();
    var number3 = controllerNumber3.text.trim();
    result2 = "";
    result3 = "";
    if (!(ToolUtility.stringIsNullOrEmpty(number2))) {
      for (int i = 0; i < number2.length; i += 2) {
        int offset = i + 2;
        result2 += number2.substring(i, offset >= number2.length ? number2.length : offset) + ", ";
      }
      result2 = result2.substring(0, result2.length - 2);
    }
    if (!(ToolUtility.stringIsNullOrEmpty(number3))) {
      for (int i = 0; i < number3.length; i += 3) {
        int offset = i + 3;
        result3 += number3.substring(i, offset >= number3.length ? number3.length : offset) + ", ";
      }
      result3 = result3.substring(0, result3.length - 2);
    }
    setState(() {});
  }

  selectDate() {
    DatePicker.showDatePicker(
      context,
      locale: LocaleType.th,
      currentTime: ToolUtility.stringIsNullOrEmpty(date) ? DateTime(DateTime.now().year + 543, 1, 1) : DateFormat(ToolUtility.ddMMyyyy).parse(date),
      minTime: DateTime(DateTime.now().year + 543, DateTime.now().month, DateTime.now().day),
      maxTime: DateTime((DateTime.now().year + 543) + 1, 12, 31),
      theme: DatePickerTheme(
        doneStyle: TextStyle(
          color: ToolUtility.colorMain,
        ),
      ),
      onConfirm: (value) {
        date = ToolUtility.convertDateString(value.toString().trim(), ToolUtility.yyyyMMdd, ToolUtility.ddMMyyyy);
        setState(() {});
      },
      onChanged: (value) {
        date = ToolUtility.convertDateString(value.toString().trim(), ToolUtility.yyyyMMdd, ToolUtility.ddMMyyyy);
        setState(() {});
      },
      onCancel: () {
        date = "";
        setState(() {});
      },
    );
  }

  save() {
    screenshotController.capture().then((Uint8List image) async {
      Directory dir;
      if (Platform.isAndroid) {
        dir = await DownloadsPathProvider.downloadsDirectory;
      } else {
        dir = await getApplicationDocumentsDirectory();
      }
      var file = File("${dir.path}/IMG_" + DateTime.now().microsecondsSinceEpoch.toString() + ".png");
      await file.writeAsBytes(image);
      OpenFile.open(file.path);
    });
  }

  Widget showContent() {
    return FutureBuilder(
      future: callData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              showInputNumber3(),
              showInputNumber2(),
              showResult(),
            ],
          );
        } else {
          return const FutureBuilderLoading();
        }
      },
    );
  }

  Widget showInputNumber2() {
    return Container(
      padding: EdgeInsets.only(
        top: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10),
        left: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10),
        right: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10),
      ),
      child: CustomInput(
        controller: controllerNumber2,
        focusColor: ToolUtility.colorMain,
        labelText: "กรอกหมายเลข (2 ตัว)",
        prefixIcon: null,
        suffixIcon: null,
        inputFormatters: <TextInputFormatter>[
          ToolUtility.textInputAllowTypeNumber,
        ],
        onChange: (value) async {
          await calculate();
        },
      ),
    );
  }

  Widget showInputNumber3() {
    return Container(
      padding: EdgeInsets.only(
        top: ToolUtility.autoSize(context, ToolUtility.responsive1px * 20),
        left: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10),
        right: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10),
      ),
      child: CustomInput(
        controller: controllerNumber3,
        focusColor: ToolUtility.colorMain,
        labelText: "กรอกหมายเลข (3 ตัว)",
        prefixIcon: null,
        suffixIcon: null,
        inputFormatters: <TextInputFormatter>[
          ToolUtility.textInputAllowTypeNumber,
        ],
        onChange: (value) async {
          await calculate();
        },
      ),
    );
  }

  Widget showResult() {
    return Flexible(
      fit: FlexFit.tight,
      child: ListView(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: ToolUtility.colorWhite,
              padding: EdgeInsets.all(ToolUtility.autoSize(context, ToolUtility.responsive1px * 10)),
              margin: EdgeInsets.only(
                left: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10),
                right: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10),
                bottom: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "เลขอั้น $date",
                    style: TextStyle(
                      color: ToolUtility.colorGreyCustom1,
                      fontWeight: FontWeight.bold,
                      fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeDate),
                    ),
                  ),
                  Text(
                    "🍊 3 ตัวตรงจ่ายบาทละ 150 บาท",
                    style: TextStyle(
                      color: ToolUtility.colorGreyCustom1,
                      fontWeight: FontWeight.bold,
                      fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                    ),
                  ),
                  Text(
                    "🍊 ตัวโต๊ดจ่ายบาทละ 35 บาท",
                    style: TextStyle(
                      color: ToolUtility.colorGreyCustom1,
                      fontWeight: FontWeight.bold,
                      fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                    ),
                  ),
                  Text(
                    "🍊 3 ตัวล่างจ่ายบาทละ 35 บาท",
                    style: TextStyle(
                      color: ToolUtility.colorGreyCustom1,
                      fontWeight: FontWeight.bold,
                      fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ToolUtility.autoSize(context, ToolUtility.responsive1px * 5),
                      bottom: ToolUtility.autoSize(context, ToolUtility.responsive1px * 5),
                    ),
                    child: Text(
                      "👇👇👇👇👇👇👇👇👇👇👇👇👇",
                      style: TextStyle(
                        color: ToolUtility.colorGreyCustom1,
                        fontWeight: FontWeight.bold,
                        fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !(ToolUtility.stringIsNullOrEmpty(result3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "3 ตัว บน ล่าง เต็ง โต๊ด 6 กลับ",
                          style: TextStyle(
                            color: ToolUtility.colorGreyCustom1,
                            fontWeight: FontWeight.bold,
                            fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10)),
                          child: Text(
                            result3,
                            style: TextStyle(
                              color: ToolUtility.colorGreyCustom1,
                              fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !(ToolUtility.stringIsNullOrEmpty(result2)),
                    child: Padding(
                      padding: EdgeInsets.only(top: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "🔶 จ่ายครึ่ง 🔶",
                            style: TextStyle(
                              color: ToolUtility.colorGreyCustom1,
                              fontWeight: FontWeight.bold,
                              fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                            ),
                          ),
                          Text(
                            "2 ตัว บน ล่าง (ตัวกลับด้วย)",
                            style: TextStyle(
                              color: ToolUtility.colorGreyCustom1,
                              fontWeight: FontWeight.bold,
                              fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: ToolUtility.autoSize(context, ToolUtility.responsive1px * 10)),
                            child: Text(
                              result2,
                              style: TextStyle(
                                color: ToolUtility.colorGreyCustom1,
                                fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => ToolUtility.popupExitApplication(context),
      child: SafeArea(
        child: Scaffold(
          key: GlobalScaffold().scaffold,
          backgroundColor: ToolUtility.colorWhite,
          appBar: AppBar(
            backgroundColor: ToolUtility.colorWhite,
            title: Text(
              "หน้าหลัก",
              style: TextStyle(
                color: ToolUtility.colorGreyCustom1,
                fontWeight: FontWeight.bold,
                fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  ToolUtility.iconCalendar,
                  color: ToolUtility.colorGreyCustom1,
                  size: ToolUtility.autoSize(context, ToolUtility.iconSizeNormal),
                ),
                onPressed: () {
                  selectDate();
                },
              ),
              IconButton(
                icon: Icon(
                  ToolUtility.iconDownload,
                  color: ToolUtility.colorGreyCustom1,
                  size: ToolUtility.autoSize(context, ToolUtility.iconSizeNormal),
                ),
                onPressed: () {
                  save();
                },
              )
            ],
          ),
          body: showContent(),
        ),
      ),
    );
  }
}
