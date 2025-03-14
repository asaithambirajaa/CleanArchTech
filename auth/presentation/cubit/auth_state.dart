// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:sarpl/core/core.dart';
import 'package:sarpl/features/auth/domain/entities/complete_signup_entity.dart';
import 'package:sarpl/features/auth/domain/entities/login_entity.dart';

import '../../domain/entities/send_otp_pwd_expiry_entity.dart';
import '../../domain/entities/verify_otp_pwd_expiry.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

abstract class TokenState extends AuthState {}

class TokenLoadingState extends TokenState {}

class TokenLoadedState extends TokenState {
  final Map<String, dynamic> token;

  TokenLoadedState({required this.token});
}

class TokenErrorState extends TokenState {
  final String errMSG;

  TokenErrorState({required this.errMSG});
}

class LoginValidationState extends AuthState {
  String userName = "";
  String password = "";
  bool obscureText = true;
  String userNameErrorTxt = "";
  String userPasswordErrorTxt = "";
  bool hasLoginSwt = false;
}

class SetMPINState extends AuthState {
  bool hasSetMPIN = false;
  bool hasForgotMPIN = false;
  String userName = "";
  String userNameErrorTxt = "";
  bool isLoading = false;
}

class CheckUserIdLoadingState extends SetMPINState {
  final String myUserId;
  final bool isSetMpin;

  CheckUserIdLoadingState({required this.myUserId, required this.isSetMpin});
}

class CheckUserIdLoadedState extends SetMPINState {
  final Map<String, dynamic> result;
  final String userId;
  final bool isSetMpin;

  CheckUserIdLoadedState({
    required this.result,
    required this.userId,
    required this.isSetMpin,
  });
}

class CheckUserIdErrorState extends SetMPINState {
  final String myUserId;
  final String errorMsg;
  final bool isSetMpin;

  CheckUserIdErrorState({
    required this.errorMsg,
    required this.myUserId,
    required this.isSetMpin,
  });
}

class GetVerificationCodeLoadingState extends SetMPINState {
  final String myUserId;
  final String mobileNo;

  GetVerificationCodeLoadingState({
    required this.myUserId,
    required this.mobileNo,
  });
}

class GetVerificationCodeLoadedState extends SetMPINState {
  final Map<String, dynamic> result;
  final String userId;
  final String mobileNo;

  GetVerificationCodeLoadedState({
    required this.result,
    required this.userId,
    required this.mobileNo,
  });
}

class GetVerificationCodeErrorState extends SetMPINState {
  final String errorMsg;

  GetVerificationCodeErrorState({required this.errorMsg});
}

class VerifyCodeLoadingState extends SetMPINState {
  /* final String myUserId; */

  VerifyCodeLoadingState(/* {required this.myUserId} */);
}

class VerifyCodeLoadedState extends SetMPINState {
  final CompleteSignUpEntity result;
  final String userId;

  VerifyCodeLoadedState({required this.result, required this.userId});
}

class VerifyCodeErrorState extends SetMPINState {
  final String errorMsg;

  VerifyCodeErrorState({required this.errorMsg});
}

class LoginLoadingState extends AuthState {}

class LoginLoadedState extends AuthState {
  final DoLoginSessionIDNewResultEntity entity;

  LoginLoadedState({required this.entity});
}

class LoginErrorState extends AuthState {
  final String errMSG;

  LoginErrorState({required this.errMSG});
}

class MpinValidateState extends AuthState {
  String newMpin = "";
  String confiMpin = "";
  String errorMsg = "";
}

class MpinLoadingState extends AuthState {}

class MpinLoadedState extends AuthState {
  final String result;

  MpinLoadedState({required this.result});
}

class MpinErrorState extends AuthState {
  final String errorMsg;

  MpinErrorState({required this.errorMsg});
}

class PasswordExpirySendOtpLoadingState extends AuthState {}

class PasswordExpirySendOtpLoadedState extends AuthState {
  final SendOTPPwdExpiryEntity result;

  PasswordExpirySendOtpLoadedState({required this.result});
}

class PasswordExpirySendOtpErrorState extends AuthState {
  final String errorMsg;

  PasswordExpirySendOtpErrorState({required this.errorMsg});
}

class PasswordExpiryVerifyOtpLoadingState extends AuthState {}

class PasswordExpiryVerifyOtpLoadedState extends AuthState {
  final VerifyOTPPwdExpiryEntity result;

  PasswordExpiryVerifyOtpLoadedState({required this.result});
}

class PasswordExpiryVerifyOtpErrorState extends AuthState {
  final String errorMsg;

  PasswordExpiryVerifyOtpErrorState({required this.errorMsg});
}

class ForgotMpinLoadingState extends AuthState {
  final String userId;
  final String mobileNo;

  ForgotMpinLoadingState({required this.userId, required this.mobileNo});
}

class ForgotMpinLoadedState extends AuthState {
  final String result;
  final String userId;
  final String mobileNo;

  ForgotMpinLoadedState({
    required this.userId,
    required this.mobileNo,
    required this.result,
  });
}

class ForgotMpinErrorState extends AuthState {
  final String errorMsg;

  ForgotMpinErrorState({required this.errorMsg});
}

class ForgotPwdLoadingState extends AuthState {
  final String userId;

  ForgotPwdLoadingState({required this.userId});
}

class ForgotPwdLoadedState extends AuthState {
  final String result;
  final String userId;

  ForgotPwdLoadedState({
    required this.userId,
    required this.result,
  });
}

class ForgotPwdErrorState extends AuthState {
  final String errorMsg;

  ForgotPwdErrorState({required this.errorMsg});
}

class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordValidationState extends AuthState {
  String oldPwd = "";
  String newPwd = "";
  String confirmPwd = "";
  String pwdErrorTxt = "";
  bool obscureTextForOld = true;
  bool obscureTextForNew = true;
  bool obscureTextForCfm = true;
  bool isLoading = false;
}

class ChangePasswordErrorState extends AuthState {
  final ServerFailure failure;

  ChangePasswordErrorState({required this.failure});
}

class ChangeMpinValidationState extends AuthState {
  String oldMpin = "";
  String newMpin = "";
  String confirmMpin = "";
  String mpinErrorTxt = "";
  bool isLoading = false;
}

class ChangeMpinErrorState extends AuthState {
  final ServerFailure failure;

  ChangeMpinErrorState({required this.failure});
}
