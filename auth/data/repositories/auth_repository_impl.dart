import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:sarpl/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:sarpl/features/auth/data/model/complete_signup_model.dart';
import 'package:sarpl/features/auth/data/model/send_otp_pwd_expiry_model.dart';
import 'package:sarpl/features/auth/data/model/verify_otp_pwd_expiry.dart';
import 'package:sarpl/features/auth/domain/entities/complete_signup_entity.dart';
import 'package:sarpl/features/auth/domain/entities/login_entity.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/core.dart';
import '../../domain/entities/send_otp_pwd_expiry_entity.dart';
import '../../domain/entities/verify_otp_pwd_expiry.dart';
import '../model/login_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  String androidId = "";
  var deviceInfo = "";

  Future<void> _getInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      deviceInfo = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    }
  }

  String _readAndroidBuildData(AndroidDeviceInfo build) {
    var deviceinfo = "";
    deviceinfo =
        """<deviceinfo><device><available>${build.isPhysicalDevice}</available><platform>Android</platform><version>${build.version.release}</version><uuid>${build.serialNumber}</uuid><androidid>${build.id}</androidid><gsfid>${build.id}</gsfid><flutter>3.27</flutter><model>${build.model}</model><manufacturer>${build.manufacturer}</manufacturer><isVirtual>false</isVirtual><serial>unknown</serial><devicename>${build.product}</devicename><nwcarrier>undefined</nwcarrier><noofslots>undefined</noofslots><versionNumber>${AppVersion.appVesrion}</versionNumber><Latitude>${global.latitude.toString()}</Latitude><longitude>${global.longitude.toString()}</longitude><connectiontype>${global.connectivityType}</connectiontype><noofsims>undefined</noofsims></device></deviceinfo>""";
    androidId = build.id;
    global.mobileModel = build.model;
    global.androidID = build.id;
    return deviceinfo;
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getToken() async {
    try {
      final res = await authRemoteDatasource.getToken();
      return Right(res);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, DoLoginSessionIDNewResultEntity>> loginService(
      Map<String, dynamic> param) async {
    await _getInfo();
    final Map<String, dynamic> formingReq = {
      "uid": param["uid"],
      "pwd": param["pwd"],
      "ver": "HYBRID;${AppVersion.appVesrion}",
      "MPIN": param["MPIN"],
      "IMEI": androidId,
      "OTP": "",
      "prpslno": "",
      "deviceinfo": deviceInfo
    };
    final finalRequestData = UtilsMethods().requestParamsEncry(
      reqAction: "doLoginAndGetSessionID_New",
      reqParams: formingReq,
    );
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          return Right(
            DoLoginSessionIDNewResultModel.fromJson(
              UtilsMethods().responseDecry("Responses", res1),
            ),
          );
        } else {
          //  final errorModel  = ErrorModel.fromJson(
          //         UtilsMethods().responseDecry("Responses", res1));
          //         if(errorModel.errMsg.toLowerCase() == "token expired") {

          //         }
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> checkUserId(String id) async {
    final Map<String, dynamic> formingReq = {"UserID": id};
    final finalRequestData = UtilsMethods()
        .requestParamsEncry(reqAction: "MB_UserDetails", reqParams: formingReq);
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          return Right(UtilsMethods().responseDecry("Responses", res1));
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getVerificationCode(
      Map<String, dynamic> params) async {
    final Map<String, dynamic> formingReq = {
      "UserID": params["id"],
      "MobileNo": params["mobileNo"]
    };
    final finalRequestData = UtilsMethods()
        .requestParamsEncry(reqAction: "InitiateSignUp", reqParams: formingReq);
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          return Right(UtilsMethods().responseDecry("Responses", res1));
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, CompleteSignUpEntity>> verifyCode(
      Map<String, dynamic> params) async {
    final Map<String, dynamic> formingReq = {
      "otpnumber": params["otpnumber"],
      "UserID": params["UserID"]
    };
    final finalRequestData = UtilsMethods()
        .requestParamsEncry(reqAction: "CompleteSignUp", reqParams: formingReq);
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          return Right(
            CompleteSignUpModel.fromJson(
              UtilsMethods().responseDecry("Responses", res1),
            ),
          );
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> setMpin(
      Map<String, dynamic> params) async {
    final Map<String, dynamic> formingReq = {
      "UserID": params["UserID"],
      "OldMPin": params["OldMPin"],
      "NewMPin": params["NewMPin"],
      "ConfirmMPin": params["ConfirmMPin"],
      "SetForgotUpdate": "S",
      "SessionID": params["SessionID"],
    };
    final finalRequestData = UtilsMethods()
        .requestParamsEncry(reqAction: "UpdateMPin", reqParams: formingReq);
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          return Right(UtilsMethods().responseDecry("Responses", res1));
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, SendOTPPwdExpiryEntity>> passwordExpirySendOTP(
      Map<String, dynamic> params) async {
    final Map<String, dynamic> formingReq = {
      "uid": params["uid"],
      if (params["purpose"] == "IMEI") "mobileno": params["mob"],
      if (params["purpose"] == "PWD") "mob": params["mob"],
      "purpose": params["purpose"],
    };
    String finalRequestData = "";
    if (params["purpose"] == "IMEI") {
      finalRequestData = UtilsMethods().requestParamsEncry(
          reqAction: "SendOTPIMEIupdation", reqParams: formingReq);
    } else {
      finalRequestData = UtilsMethods().requestParamsEncry(
          reqAction: "SendOTPPwdExpiry", reqParams: formingReq);
    }
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          if (params["purpose"] == "IMEI") {
            return Right(
              SendOTPIMEIChangeModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            );
          } else {
            return Right(
              SendOTPPwdExpiryModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            );
          }
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, VerifyOTPPwdExpiryEntity>> passwordExpiryVerifyOTP(
      Map<String, dynamic> params) async {
    await _getInfo();
    final Map<String, dynamic> formingReq = {
      "PkId": params["PkId"],
      "OTP": params["OTP"],
      "IMEI": androidId,
      "GSFID": androidId,
      "userid": params["userid"],
      "purpose": params["purpose"],
    };
    String finalRequestData = "";
    if (params["purpose"] == "DID") {
      finalRequestData = UtilsMethods().requestParamsEncry(
          reqAction: "OTPIMEIVerification", reqParams: formingReq);
    } else {
      finalRequestData = UtilsMethods().requestParamsEncry(
          reqAction: "VerifyOTPPwdExpiry", reqParams: formingReq);
    }
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          if (params["purpose"] == "DID") {
            return Right(
              IMEIChangeVerifyOTPModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            );
          } else {
            return Right(
              VerifyOTPPwdExpiryModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            );
          }
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> forgotMpin(
      Map<String, dynamic> params) async {
    final Map<String, dynamic> formingReq = {
      "UserID": params["id"],
      "mobile": params["mobileNo"]
    };
    final finalRequestData = UtilsMethods()
        .requestParamsEncry(reqAction: "ForgotMPin", reqParams: formingReq);
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          return Right(UtilsMethods().responseDecry("Responses", res1));
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> forgotPassword(
      Map<String, dynamic> params) async {
    final Map<String, dynamic> formingReq = {
      "uid": params["uid"],
    };
    final finalRequestData = UtilsMethods()
        .requestParamsEncry(reqAction: "ForgotPassword", reqParams: formingReq);
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          return Right(UtilsMethods().responseDecry("Responses", res1));
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> changePassword(
      Map<String, dynamic> params) async {
    final Map<String, dynamic> formingReq = {
      "UserID": params["UserID"],
      "OldPassword": params["OldPassword"],
      "NewPassword": params["NewPassword"],
      "ConfirmPassword": params["ConfirmPassword"],
    };
    final finalRequestData = UtilsMethods()
        .requestParamsEncry(reqAction: "ChangePassword", reqParams: formingReq);
    final Map<String, dynamic> requestParams = {"qs": finalRequestData};
    try {
      final res = await authRemoteDatasource.commonLoginService(requestParams);
      if (res['LoginServiceCallResult'] != null) {
        final res1 = res['LoginServiceCallResult'];
        if (res1['Status']) {
          return Right(UtilsMethods().responseDecry("Responses", res1));
        } else {
          return Left(
            handleException(
              ErrorModel.fromJson(
                UtilsMethods().responseDecry("Responses", res1),
              ),
            ),
          );
        }
      } else {
        return Left(handleException(SomethingWentWrongException()));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
