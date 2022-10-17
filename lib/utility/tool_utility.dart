import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thamhuai/utility/custom_button.dart';

class ToolUtility {
  static String appName = "ทำหวย";
  static String downloadFilePath = "Path of the downloaded file : " + (Platform.isAndroid ? "Internal Storage/Download/" : "File/ThamHuai/");
  static String ddMMyyyy = "dd/MM/yyyy";
  static String yyyyMMdd = "yyyy-MM-dd";
  static double responsive1px = 0.0025;
  static DialogType dialogTypeNormal = DialogType.INFO;
  static DialogType dialogTypeError = DialogType.ERROR;
  static DialogType dialogTypeConfirm = DialogType.QUESTION;
  static FilteringTextInputFormatter textInputAllowTypeNumber = FilteringTextInputFormatter.allow(RegExp(r"[0-9]"));

  //Color
  static Map<int, Color> colorMainPrimarySwatch = {
    50: colorMain,
    100: colorMain,
    200: colorMain,
    300: colorMain,
    400: colorMain,
    500: colorMain,
    600: colorMain,
    700: colorMain,
    800: colorMain,
    900: colorMain,
  };
  static int colorMainHax = 0xFF339400;
  static Color colorMain = Colors.green;
  static Color colorWhite = Colors.white;
  static Color colorRed = Colors.redAccent;
  static Color colorTransparent = Colors.transparent;
  static Color colorGreyCustom1 = const Color.fromRGBO(51, 51, 51, 0.8);

  //Other Size
  static double buttonBorderRadius = responsive1px * 8;

  //Icon Size
  static double iconSizeNormal = responsive1px * 28;

  //Font Size
  static String fontName = "Mitr";
  static double fontSizeNormal = responsive1px * 16;
  static double fontSizePopupHeader = responsive1px * 20;
  static double fontSizeButton = responsive1px * 18;
  static double fontSizeAppBar = responsive1px * 20;
  static double fontSizeDate = responsive1px * 20;

  //Icon
  static IconData iconOK = Icons.check;
  static IconData iconClose = Icons.close;
  static IconData iconDownload = Icons.download;
  static IconData iconCalendar = Icons.calendar_month;

  static popupCore(BuildContext context, DialogType dialogType, Widget body, Widget buttonOK, Widget buttonCancel) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.BOTTOMSLIDE,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: autoSize(context, responsive1px * 10), right: autoSize(context, responsive1px * 10)),
        child: body,
      ),
      padding: EdgeInsets.only(bottom: autoSize(context, responsive1px * 5)),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOk: stringIsNullOrEmpty(buttonCancel) ? null : buttonCancel,
      btnCancel: stringIsNullOrEmpty(buttonOK) ? null : buttonOK,
    ).show();
  }

  static popupAll(BuildContext context, String message, DialogType dialogType) {
    var body = Column(
      children: [
        titlePopup(context, message),
      ],
    );
    popupCore(
      context,
      dialogType,
      body,
      CustomButton(
        text: "ตกลง",
        icon: iconOK,
        color: colorMain,
        onClick: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      null,
    );
  }

  static popupExitApplication(BuildContext context) {
    var body = Column(
      children: [
        titlePopup(context, "ยืนยันการออกจากแอปพลิเคชัน ?"),
      ],
    );
    popupCore(
      context,
      dialogTypeConfirm,
      body,
      CustomButton(
        text: "ตกลง",
        icon: iconOK,
        color: colorMain,
        onClick: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      ),
      CustomButton(
        text: "ยกเลิก",
        icon: iconClose,
        color: colorRed,
        onClick: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  static loading(bool isShow) async {
    if (isShow) {
      BotToast.showLoading(
        backButtonBehavior: BackButtonBehavior.ignore,
        backgroundColor: colorTransparent,
      );
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        BotToast.closeAllLoading();
      });
    }
  }

  static requestPermissions() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage
      ].request();
    }
  }

  static bool stringIsNullOrEmpty(dynamic data) {
    return ["", "null", null].contains(data);
  }

  static bool isNumberZero(int data) {
    return ["0", 0].contains(data);
  }

  static double autoSize(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * size;
  }

  static String numberFormat(String text) {
    if (stringIsNullOrEmpty(text)) {
      return "0";
    } else {
      return NumberFormat("#,###.##").format(double.parse(text));
    }
  }

  static String convertDateString(String date, String fromFormat, String toFormat) {
    if (stringIsNullOrEmpty(date)) {
      return "";
    } else {
      return DateFormat(toFormat).format(DateFormat(fromFormat).parse(date.trim()));
    }
  }

  static Widget titlePopup(BuildContext context, String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: colorGreyCustom1,
        fontWeight: FontWeight.bold,
        fontSize: autoSize(context, fontSizePopupHeader),
      ),
    );
  }

  static OutlineInputBorder borderInput(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(autoSize(context, responsive1px * 5)),
      ),
    );
  }
}
