import 'package:sarpl/features/auth/presentation/pages/auth_page.dart';
import 'package:sarpl/features/splash_page.dart';

import '../core.dart';

class HeaderConfig {
  Map<String, String> header({bool isGetToken = true, bool isLogin = false}) {
    if (isGetToken) {
      return {'Content-Type': 'application/json', 'AuthKey': AuthKey.kAuthKey};
    } else if (isLogin) {
      //init();
      return {
        'AuthKey': AuthKey.kAuthKey,
        'AuthTkn': tkn.token,
        'Content-Type': 'application/json',
      };
    } else {
      return {
        'SessionID': loginBasicInfo.sessionId,
        'RegId': "",
        'Unit': loginBasicInfo.unit,
        'UserName': loginBasicInfo.userId,
        'Screen': 'C',
        'setTPIN': 'V',
        'AndroidID': global.androidID,
        'GSFID': global.androidID,
        "Lantitude": global.latitude.toString(),
        "Longitude": global.longitude.toString(),
        "AdviceNo": adviceNo,
        "Pk_id": imagePkId,
        "Doc": "",
        'Content-Type': 'application/json',
      };
    }
  }
}
