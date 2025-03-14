import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sarpl/core/core.dart';

enum DeviceType { phone, tablet }

class UtilsMethods {
  final Connectivity _connectivity = Connectivity();
  static void debugLog(String logStr) {
    if (kDebugMode) {
      log(logStr);
    }
  }

  Future<String> getConnectivityType() async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile)) {
      return "mobile";
    } else if (result.contains(ConnectivityResult.wifi)) {
      return "wifi";
    } else if (result.contains(ConnectivityResult.bluetooth)) {
      return "bluetooth";
    } else if (result.contains(ConnectivityResult.ethernet)) {
      return "ethernet";
    } else if (result.contains(ConnectivityResult.vpn)) {
      return "vpn";
    } else {
      return "other";
    }
  }

  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return _emitConnectivityState(result);
  }

  bool _emitConnectivityState(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: SARPLColors.secondaryColor,
          content: UtilsMethods().noInternetText(),
        ),
      );
      return false;
    }
  }

  static callSnackbar(BuildContext context, String mesg,
      {Color? backgroundColor, Color? txtColor}) {
    final snackBar = SnackBar(
      content: Text(
        mesg,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: txtColor ?? SARPLColors.primaryColor,
            ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor ?? SARPLColors.white,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String encryptStringAES(
      String plainText, String encryptKey, String encryptIV) {
    final key = encrypt.Key.fromUtf8(encryptKey);
    final iv = encrypt.IV.fromUtf8(encryptIV);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, padding: "PKCS7", mode: encrypt.AESMode.cbc),
    );

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decryptStringAES(
      String cipherText, String decryptKey, String decryptIV) {
    final key = encrypt.Key.fromUtf8(decryptKey);
    final iv = encrypt.IV.fromUtf8(decryptIV);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, padding: "PKCS7", mode: encrypt.AESMode.cbc),
    );

    try {
      final decrypted = encrypter.decrypt64(cipherText, iv: iv);
      return decrypted;
    } catch (e) {
      return "keyError";
    }
  }

  String requestParamsEncry({
    String reqAction = "",
    required Map<String, dynamic> reqParams,
    List<Map<String, dynamic>>? reqParamsLst,
    String? reqParamsStr,
  }) {
    String jsonString = "";
    if (reqParamsStr != null) {
      jsonString = reqParamsStr;
    } else if (reqParamsLst != null) {
      jsonString = jsonEncode(reqParamsLst);
    } else {
      jsonString = jsonEncode(reqParams);
    }
    final finalRequestData = "$reqAction&&$jsonString&&${TimeStemp.timeStemp}";
    final reqParamsEncode = UtilsMethods().encryptStringAES(
      finalRequestData,
      AuthKey.kDeCryptKey,
      AuthKey.kDeCryptIV,
    );
    return reqParamsEncode;
  }

  responseDecry(String key, dynamic res) {
    final des = UtilsMethods().decryptStringAES(
      res[key],
      AuthKey.kEnCryptKey,
      AuthKey.kEnCryptIV,
    );
    final decryptJson = jsonDecode(des);
    return decryptJson;
  }

  DeviceType getDeviceType() {
    final MediaQueryData data = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single);
    return data.size.shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
  }

  bool setMpinErrorMpin(String secretMPIN) {
    int value1 = int.parse(secretMPIN.substring(0, 1));
    int value2 = int.parse(secretMPIN.substring(1, 2));
    int value3 = int.parse(secretMPIN.substring(2, 3));
    int value4 = int.parse(secretMPIN.substring(3, 4));

    if ((value1 == value2) && (value1 == value3) && (value1 == value4)) {
      return true;
    } else if ((value1 == value2 + 1) &&
        (value1 == value3 + 2) &&
        (value1 == value4 + 3)) {
      return true;
    } else if ((value4 == value3 + 1) &&
        (value4 == value2 + 2) &&
        (value4 == value1 + 3)) {
      return true;
    } else {
      return false;
    }
  }

  void showSaveGifProgressBar(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: SARPLColors.white,
          content: loadingWidget(context, message, MainAxisAlignment.start),
        );
      },
    );
  }

  loadingWidget(
      BuildContext context, String message, MainAxisAlignment mainAxisAlignment,
      [Color? color]) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      spacing: 10,
      children: [
        Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          child: Image.asset(SARPLAssetsConstants.gifLoadingCircle),
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: color ?? SARPLColors.black,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  ///[showLoadingWidget] - This is a widget for loading widget(Use builder method)
  showLoadingWidget(
    BuildContext context,
    String message,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          //color: SARPLColors.lightGrey,
          child: UtilsMethods()
              .loadingWidget(context, message, MainAxisAlignment.start),
        ),
      ),
    );
  }

  noInternetText() {
    return Text(
      "No internet connection!",
      style: Theme.of(scaffoldMessengerKey.currentContext!)
          .textTheme
          .bodyLarge!
          .copyWith(
            color: SARPLColors.black,
          ),
    );
  }

  // Function to show date picker
  Future<DateTime> selectDate(
      BuildContext context, DateTime? selectedDate) async {
    final DateTime now = DateTime.now();
    // Show the date picker
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), // Initial date
      firstDate: DateTime(2000), // First date available for selection
      lastDate: now, // Last date available for selection
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            hintColor: SARPLColors.primaryColor,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme:
                const ColorScheme.light(primary: SARPLColors.primaryColor),
            // Customizing text style of header, and other parts
            textTheme: TextTheme(
              titleLarge: Theme.of(context).textTheme.headlineMedium,
              bodyMedium: Theme.of(context).textTheme.headlineSmall,
            ),
            // Customizing the calendar text styles
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: SARPLColors.primaryColor,
                  textStyle: Theme.of(context).textTheme.labelMedium),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    return selectedDate!;
  }

  CupertinoActionSheet iOSStyleActionSheet({
    required BuildContext context,
    String title = "",
    required Function() onCancelBtn,
    List<Widget>? actions,
  }) {
    return CupertinoActionSheet(
      title: title.isEmpty
          ? null
          : Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: SARPLColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
      actions: actions,
      cancelButton: CupertinoActionSheetAction(
        onPressed: onCancelBtn,
        isDefaultAction: true,
        isDestructiveAction: true,
        child: Text(
          StringConstants.kCancel,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: SARPLColors.primaryColor,
                fontSize: 18,
              ),
        ),
      ),
    );
  }

  CupertinoActionSheetAction iOSActionBtns({
    required BuildContext context,
    required String btnLabel,
    required double width,
    String iconName = "",
    required Function() onPressed,
  }) {
    return CupertinoActionSheetAction(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: width),
        child: (iconName.isEmpty)
            ? Text(
                btnLabel,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: SARPLColors.primaryColor,
                    ),
              )
            : Row(
                spacing: 8,
                children: [
                  Image.asset(iconName),
                  Text(
                    btnLabel,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: SARPLColors.primaryColor,
                        ),
                  ),
                ],
              ),
      ),
    );
  }

  customLabelTxtWidget({
    required BuildContext context,
    required String txtLabel,
    Color? txtLabelColor,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return Text(
      txtLabel,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: txtLabelColor ?? SARPLColors.black,
            fontWeight: fontWeight ?? FontWeight.bold,
            fontSize: fontSize ??
                (UtilsMethods().getDeviceType() == DeviceType.phone ? 14 : 18),
          ),
    );
  }

  rowBoldTitleWidget({
    required BuildContext context,
    required String txtLabel,
    // required Widget customWidget,
  }) {
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customLabelTxtWidget(
          context: context,
          txtLabel: txtLabel,
          fontSize:
              UtilsMethods().getDeviceType() == DeviceType.phone ? 16 : 20,
        ),
        // customWidget,
      ],
    );
  }

  showIOSDialog(BuildContext context, String title, String contentTxt,
      {Function()? onPressed, bool isCancelHide = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          content: Text(
            contentTxt,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: <Widget>[
            if (!isCancelHide)
              CupertinoDialogAction(
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            CupertinoDialogAction(
              onPressed: onPressed,
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }

  showBottomSheet(BuildContext context, Widget customWidget) {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return customWidget;
      },
    );
  }

  String convertIntoBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64File = base64Encode(imageBytes);
    return base64File;
  }

  positionedCloseBtnWidget({
    required BuildContext context,
    Function()? onPressed,
  }) {
    return Positioned(
      right: 10,
      top: 10,
      child: GestureDetector(
        onTap: () {
          UtilsMethods().showIOSDialog(
            context,
            "Alert",
            "Do you want to remove the captured image.",
            isCancelHide: false,
            onPressed: onPressed,
          );
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withValues(alpha: 0.5),
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    required String title,
    String okBtnText = "",
    String cancelBtnText = "",
    required void Function()? okBtnFunction,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: SARPLColors.white,
          title: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          //content:  Here add your custom widget,
          actions: <Widget>[
            TextButton(
              onPressed: okBtnFunction,
              child: Text(
                okBtnText,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            if (cancelBtnText.isNotEmpty)
              TextButton(
                child: Text(
                  cancelBtnText,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                onPressed: () => Navigator.pop(context),
              ),
          ],
        );
      },
    );
  }
}
