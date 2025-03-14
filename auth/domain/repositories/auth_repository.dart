import 'package:dartz/dartz.dart';
import 'package:sarpl/core/core.dart';
import 'package:sarpl/features/auth/domain/entities/complete_signup_entity.dart';
import 'package:sarpl/features/auth/domain/entities/login_entity.dart';

import '../entities/send_otp_pwd_expiry_entity.dart';
import '../entities/verify_otp_pwd_expiry.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> getToken();
  Future<Either<Failure, DoLoginSessionIDNewResultEntity>> loginService(
      Map<String, dynamic> param);
  Future<Either<Failure, Map<String, dynamic>>> checkUserId(String id);
  Future<Either<Failure, Map<String, dynamic>>> getVerificationCode(
      Map<String, dynamic> params);
  Future<Either<Failure, CompleteSignUpEntity>> verifyCode(
      Map<String, dynamic> params);
  Future<Either<Failure, Map<String, dynamic>>> setMpin(
      Map<String, dynamic> params);
  Future<Either<Failure, SendOTPPwdExpiryEntity>> passwordExpirySendOTP(
      Map<String, dynamic> params);
  Future<Either<Failure, VerifyOTPPwdExpiryEntity>> passwordExpiryVerifyOTP(
      Map<String, dynamic> params);
  Future<Either<Failure, Map<String, dynamic>>> forgotMpin(
      Map<String, dynamic> params);
  Future<Either<Failure, Map<String, dynamic>>> forgotPassword(
      Map<String, dynamic> params);
  Future<Either<Failure, Map<String, dynamic>>> changePassword(
      Map<String, dynamic> params);
}
