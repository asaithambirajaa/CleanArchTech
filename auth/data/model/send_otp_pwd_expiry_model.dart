import 'package:sarpl/features/auth/domain/entities/send_otp_pwd_expiry_entity.dart';

class SendOTPIMEIChangeModel extends SendOTPPwdExpiryEntity {
  const SendOTPIMEIChangeModel({required super.sendOTPPwdExpiryResult});

  factory SendOTPIMEIChangeModel.fromJson(Map<String, dynamic> json) {
    return SendOTPIMEIChangeModel(
      sendOTPPwdExpiryResult: SendOTPPwdExpiryResult.fromJson(
        json['SendOTPIMEIupdationResult'],
      ),
    );
  }
}

class SendOTPPwdExpiryModel extends SendOTPPwdExpiryEntity {
  const SendOTPPwdExpiryModel({required super.sendOTPPwdExpiryResult});

  factory SendOTPPwdExpiryModel.fromJson(Map<String, dynamic> json) {
    return SendOTPPwdExpiryModel(
      sendOTPPwdExpiryResult: SendOTPPwdExpiryResult.fromJson(
        json['SendOTPPwdExpiryResult'],
      ),
    );
  }
}

class SendOTPPwdExpiryResult extends SendOTPPwdExpiryResultEntity {
  const SendOTPPwdExpiryResult({
    required super.errType,
    required super.errMsg,
    required super.pkId,
    required super.oTPNo,
  });

  factory SendOTPPwdExpiryResult.fromJson(Map<String, dynamic> json) {
    return SendOTPPwdExpiryResult(
      errType: json['ErrType'] ?? "",
      errMsg: json['ErrMsg'] ?? "",
      pkId: json['PkId'] ?? "",
      oTPNo: json['OTPNo'] ?? "",
    );
  }
}
