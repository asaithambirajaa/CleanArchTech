import 'package:sarpl/features/auth/domain/entities/verify_otp_pwd_expiry.dart';

class IMEIChangeVerifyOTPModel extends VerifyOTPPwdExpiryEntity {
  const IMEIChangeVerifyOTPModel({required super.verifyOTPPwdExpiryResult});

  factory IMEIChangeVerifyOTPModel.fromJson(Map<String, dynamic> json) {
    return IMEIChangeVerifyOTPModel(
      verifyOTPPwdExpiryResult: VerifyOTPPwdExpiryResult.fromJson(
        json['OTPIMEIVerificationResult'],
      ),
    );
  }
}

class VerifyOTPPwdExpiryModel extends VerifyOTPPwdExpiryEntity {
  const VerifyOTPPwdExpiryModel({required super.verifyOTPPwdExpiryResult});

  factory VerifyOTPPwdExpiryModel.fromJson(Map<String, dynamic> json) {
    return VerifyOTPPwdExpiryModel(
      verifyOTPPwdExpiryResult: VerifyOTPPwdExpiryResult.fromJson(
        json['VerifyOTPPwdExpiryResult'],
      ),
    );
  }
}

class VerifyOTPPwdExpiryResult extends VerifyOTPPwdExpiryResultEntity {
  const VerifyOTPPwdExpiryResult({required super.result});

  factory VerifyOTPPwdExpiryResult.fromJson(Map<String, dynamic> json) {
    return VerifyOTPPwdExpiryResult(result: json['Result'] ?? "");
  }
}
