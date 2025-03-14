class AuthKey {
  static const kAuthKey = "vB6ZxuX+cnIdIwvTm1cF0Q==";
  static const kEnCryptKey = "9513574562580759";
  static const kEnCryptIV = "7648513279456184";
  static const kDeCryptKey = "7485679453281654";
  static const kDeCryptIV = "5479468543218548";
}

class Token {
  String _token = '';

  String get token => _token;

  set token(String tkn) {
    if (tkn.isNotEmpty) {
      _token = tkn;
    }
  }
}

class LoginBasicInfo {
  String _sessionID = '';
  String _unit = '';
  String _userID = '';
  String _userName = '';
  String _mobileNm = "";
  int _minMobNoRng = 100;
  int _maxMobNoRng = 100;

  String get sessionId => _sessionID;
  String get unit => _unit;
  String get userId => _userID;
  String get userName => _userName;
  String get mobileNM => _mobileNm;
  int get minMobNoRng => _minMobNoRng;
  int get maxMobNoRng => _maxMobNoRng;

  set minMobNoRng(int minMobNoRng) {
    if (minMobNoRng != 100) _minMobNoRng = minMobNoRng;
  }

  set maxMobNoRng(int maxMobNoRng) {
    if (maxMobNoRng != 100) _maxMobNoRng = maxMobNoRng;
  }

  set sessionId(String sesId) {
    if (sesId.isNotEmpty) {
      _sessionID = sesId;
    }
  }

  set userId(String uid) {
    if (uid.isNotEmpty) {
      _userID = uid;
    }
  }

  set userName(String name) {
    if (name.isNotEmpty) {
      _userName = name;
    }
  }

  set unit(String unit) {
    if (unit.isNotEmpty) {
      _unit = unit;
    }
  }

  set mobileNM(String mobileNM) {
    if (mobileNM.isNotEmpty) {
      _mobileNm = mobileNM;
    }
  }
}
