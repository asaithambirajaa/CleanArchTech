import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sarpl/core/core.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/change_password_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/check_userid_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/forgot_mpin_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/forgot_pwd_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/get_token_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/get_verification_code_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/login_service_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/password_expiry_send_otp_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/set_mpin_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/verify_code_usecase.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_state.dart';

import '../../domain/usecase/password_expiry_verify_otp_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginServiceUsecase loginServiceUsecase;
  final GetTokenUsecase getTokenUsecase;
  final CheckUserIdUsecase checkUserIdUsecase;
  final GetVerificationCodeUsecase getVerificationCodeUsecase;
  final VerifyCodeUsecase verifyCodeUsecase;
  final SetMpinUsecase setMpinUsecase;
  final ForgotMpinUsecase forgotMpinUsecase;
  final ForgotPwdUsecase forgotPwdUsecase;
  final PasswordExpirySendOTPUsecase passwordExpirySendOtpUsecase;
  final PasswordExpiryVerifyOTPUsecase passwordExpiryVerifyOtpUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final LocalAuthentication auth = LocalAuthentication();

  AuthCubit(
    this.loginServiceUsecase,
    this.getTokenUsecase,
    this.checkUserIdUsecase,
    this.getVerificationCodeUsecase,
    this.verifyCodeUsecase,
    this.setMpinUsecase,
    this.forgotMpinUsecase,
    this.passwordExpirySendOtpUsecase,
    this.passwordExpiryVerifyOtpUsecase,
    this.forgotPwdUsecase,
    this.changePasswordUsecase,
  ) : super(AuthInitialState());

  initialRefresh({bool showMpinWidget = true}) {
    // LoginValidationState state = LoginValidationState();
    // state.hasLoginSwt = showMpinWidget;
    emit(LoginValidationState());
  }

  initialChangePwdRefresh() {
    emit(ChangePasswordValidationState());
  }

  initialChangeMpinRefresh() {
    emit(ChangeMpinValidationState());
  }

  getToken() async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(TokenLoadingState());
      final res = await getTokenUsecase.call(NoParams());
      return res.fold(
        (l) => emit(TokenErrorState(errMSG: l.toString())),
        (r) => emit(TokenLoadedState(token: r)),
      );
    }
  }

  Future validateCredentials(
    LoginValidationState state,
    BuildContext context,
    String userNameController,
    String passwordController,
    String mpin,
  ) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(AuthInitialState());
      if (state.userName.isNotEmpty && userNameController.isNotEmpty) {
        state.userNameErrorTxt = "";
        if (state.password.isNotEmpty && passwordController.isNotEmpty) {
          state.userPasswordErrorTxt = "";
          if (context.mounted) {
            BlocProvider.of<AuthCubit>(context)
                .userLogin(state.userName, state.password, mpin: mpin);
          }
        } else {
          state.userPasswordErrorTxt = "Please Enter Valid Password";
        }
      } else {
        state.userNameErrorTxt = "Please Enter valid UserName";
      }
      emit(state);
    }
  }

  Future changePwdvalidateCredentials(
    ChangePasswordValidationState state,
    BuildContext context,
    String oldPwdController,
    String newPwdController,
    String cfmPwdController,
    String userID,
  ) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(AuthInitialState());
      if (state.oldPwd.isNotEmpty && oldPwdController.isNotEmpty) {
        state.pwdErrorTxt = "";
        if (state.newPwd.isNotEmpty && newPwdController.isNotEmpty) {
          state.pwdErrorTxt = "";
          if (state.confirmPwd.isNotEmpty && cfmPwdController.isNotEmpty) {
            state.pwdErrorTxt = "";
            if (state.confirmPwd == state.newPwd) {
              if (context.mounted) {
                final Map<String, dynamic> params = {
                  "UserID": userID,
                  "OldPassword": state.oldPwd,
                  "NewPassword": state.newPwd,
                  "ConfirmPassword": state.confirmPwd,
                };
                BlocProvider.of<AuthCubit>(context)
                    .changePassword(state, params);
              }
            } else {
              state.pwdErrorTxt =
                  "New password and confirm password should be same";
            }
          } else {
            state.pwdErrorTxt = "Please Enter Confirm Password";
          }
        } else {
          state.pwdErrorTxt = "Please Enter New Password";
        }
      } else {
        state.pwdErrorTxt = "Please Enter Old Password";
      }
      emit(state);
    }
  }

  Future changeMpinvalidateCredentials(
    ChangeMpinValidationState state,
    BuildContext context,
    String oldMPinController,
    String newMpinController,
    String cfmMpinController,
    String userID,
  ) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(AuthInitialState());
      state.isLoading = false;
      if (state.oldMpin.isNotEmpty && oldMPinController.isNotEmpty) {
        state.mpinErrorTxt = "";
        if (state.newMpin.isNotEmpty && newMpinController.isNotEmpty) {
          state.mpinErrorTxt = "";
          if (state.confirmMpin.isNotEmpty && cfmMpinController.isNotEmpty) {
            state.mpinErrorTxt = "";
            if (state.confirmMpin == state.newMpin) {
              if (context.mounted) {
                state.isLoading = true;
                final Map<String, dynamic> params = {
                  "UserID": userID,
                  "OldPassword": state.oldMpin,
                  "NewPassword": state.newMpin,
                  "ConfirmPassword": state.confirmMpin,
                };
                // BlocProvider.of<AuthCubit>(context)
                //     .changePassword(state, params);
              }
            } else {
              state.mpinErrorTxt = "New Mpin and confirm Mpin should be same";
            }
          } else {
            state.mpinErrorTxt = "Please Enter Confirm Mpin";
          }
        } else {
          state.mpinErrorTxt = "Please Enter New Mpin";
        }
      } else {
        state.mpinErrorTxt = "Please Enter Old Mpin";
      }
      emit(state);
    }
  }

  Future loginMpinToggleChangeUI(
    LoginValidationState state,
    bool isLoginMpin,
  ) async {
    emit(AuthInitialState());
    _clearData(state, true);
    state.hasLoginSwt = isLoginMpin;
    //state.obscureText = state.obscureText;
    emit(state);
  }

  Future setAndForgotMpinChangeUI(LoginValidationState state,
      {bool isSetMpin = true}) async {
    emit(AuthInitialState());
    SetMPINState mpinState = SetMPINState();
    mpinState.hasForgotMPIN = !isSetMpin;
    mpinState.hasSetMPIN = isSetMpin;
    emit(mpinState);
  }

  Future passwordVisibler(LoginValidationState state) async {
    emit(AuthInitialState());
    _clearData(state, false);
    state.obscureText = !state.obscureText;
    emit(state);
  }

  _clearData(LoginValidationState state, bool isLoginMpinToggle) {
    state.userNameErrorTxt = "";
    state.userPasswordErrorTxt = "";
    if (isLoginMpinToggle) {
      state.userName = "";
      state.password = "";
    }
  }

  Future changePasswordVisibler(
    ChangePasswordValidationState state,
    bool obscureTextForOld,
    bool obscureTextForNew,
    bool obscureTextForCfm,
  ) async {
    emit(AuthInitialState());
    state.pwdErrorTxt = "";
    if (obscureTextForOld) state.obscureTextForOld = !state.obscureTextForOld;
    if (obscureTextForNew) state.obscureTextForNew = !state.obscureTextForNew;
    if (obscureTextForCfm) state.obscureTextForCfm = !state.obscureTextForCfm;
    emit(state);
  }

  Future userLogin(String userName, String password,
      {String mpin = "N"}) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(LoginLoadingState());
      final Map<String, dynamic> params = {
        "uid": userName,
        "pwd": password,
        "MPIN": mpin
      };
      final res = await loginServiceUsecase.call(params);
      return res.fold(
        (l) => emit(LoginErrorState(errMSG: (l as ServerFailure).message)),
        (r) => emit(LoginLoadedState(entity: r)),
      );
    }
  }

  Future<void> loginWithLocalBiometrics() async {
    //emit(LoginRequested());
    bool authoticated = await _authenticationViaLocalBiometrics();
    if (authoticated) {
      // emit(LocalAuthProcessed());
    } else {}
  }

  Future<bool> _authenticationViaLocalBiometrics() async {
    bool authenticatedUser = false;
    try {
      bool hasbiometrics = await auth.canCheckBiometrics;
      if (hasbiometrics) {
        List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();
        if (Platform.isIOS) {
          if (availableBiometrics.contains(BiometricType.face)) {
            authenticatedUser = await auth.authenticate(
              localizedReason: 'Authenticate with fingerprint',
            );
          }
        } else {
          if (availableBiometrics.contains(BiometricType.strong)) {
            authenticatedUser = await auth.authenticate(
              localizedReason:
                  "Unlock your screen with PIN, pattern, password, face or fingerprint",
            );
          }
        }
      }
    } catch (e) {
      // "Error while opening fingerprint/face scanner"
    }
    return authenticatedUser;
  }

  checkUserId(String params, bool isSetMpin) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(CheckUserIdLoadingState(myUserId: params, isSetMpin: isSetMpin));
      final res = await checkUserIdUsecase.call(params);

      return res.fold(
        (l) => emit(CheckUserIdErrorState(
          errorMsg: l.toString(),
          myUserId: params,
          isSetMpin: isSetMpin,
        )),
        (r) {
          final result = r["MB_UserDetailsResult"].toString().split("\$");
          if (result.isNotEmpty) {
            if (result[0] == "ERROR") {
              emit(
                CheckUserIdErrorState(
                  errorMsg: result[1].toString(),
                  myUserId: params,
                  isSetMpin: isSetMpin,
                ),
              );
            } else {
              emit(CheckUserIdLoadedState(
                  result: r, userId: params, isSetMpin: isSetMpin));
            }
          }
        },
      );
    }
  }

  getVerificationCode(Map<String, dynamic> params) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(
        GetVerificationCodeLoadingState(
          mobileNo: params["mobileNo"],
          myUserId: params["id"],
        ),
      );
      final res = await getVerificationCodeUsecase.call(params);
      return res.fold(
        (l) => emit(GetVerificationCodeErrorState(errorMsg: l.toString())),
        (r) => emit(GetVerificationCodeLoadedState(
          result: r,
          userId: params["id"],
          mobileNo: params["mobileNo"],
        )),
      );
    }
  }

  verifyCode(Map<String, dynamic> params) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(VerifyCodeLoadingState());
      final res = await verifyCodeUsecase.call(params);
      return res.fold(
        (l) => emit(VerifyCodeErrorState(errorMsg: l.toString())),
        (r) {
          if (r.completeSignUpResult.errorMessage.toString().isEmpty) {
            emit(VerifyCodeLoadedState(result: r, userId: params['UserID']));
          } else {
            emit(
              VerifyCodeErrorState(
                errorMsg: r.completeSignUpResult.errorMessage.toString(),
              ),
            );
          }
        },
      );
    }
  }

  validateMpin(MpinValidateState state, BuildContext context, String newMpin,
      String confiMpin, Map<String, dynamic> params,
      {bool isSequenceCheck = false}) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(MpinLoadingState());
      bool isApiCall = false;
      state.errorMsg = "";
      if (state.newMpin.isNotEmpty &&
          newMpin.isNotEmpty &&
          state.confiMpin.isNotEmpty &&
          confiMpin.isNotEmpty) {
        final isSequenceNMpin = UtilsMethods().setMpinErrorMpin(newMpin);
        final isSequenceCMpin = UtilsMethods().setMpinErrorMpin(confiMpin);
        if (isSequenceNMpin || isSequenceCMpin) {
          state.errorMsg = ErrorMSGConstants.sequenceNumberNotAllowed;
        } else {
          if ((newMpin != confiMpin)) {
            state.errorMsg = ErrorMSGConstants.kMpinNotMatchMSG;
          } else {
            isApiCall = true;
            if (context.mounted) context.read<AuthCubit>().setMpin(params);
          }
        }
      }
      if (newMpin.isNotEmpty && newMpin.length < 4) {
        state.errorMsg = ErrorMSGConstants.kMpinLengthMSG;
      }

      if (confiMpin.isNotEmpty && confiMpin.length < 4) {
        state.errorMsg = ErrorMSGConstants.kConfiMpinLengthMSG;
      }
      if (isSequenceCheck) {
        state.errorMsg = ErrorMSGConstants.sequenceNumberNotAllowed;
      }
      if (!isApiCall) emit(state);
    }
  }

  setMpin(Map<String, dynamic> params) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(MpinLoadingState());
      final res = await setMpinUsecase.call(params);
      return res.fold(
        (l) => emit(MpinErrorState(errorMsg: l.toString())),
        (r) {
          final result = r["UpdateMPinResult"].toString().split("\$");
          if (result[0].toUpperCase() == "ERROR") {
            emit(
              MpinErrorState(errorMsg: result[1].toString()),
            );
          } else {
            emit(MpinLoadedState(result: result[1]));
          }
        },
      );
    }
  }

  sendOTP(Map<String, dynamic> params) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(PasswordExpirySendOtpLoadingState());
      final res = await passwordExpirySendOtpUsecase.call(params);
      return res.fold(
        (l) => emit(
          PasswordExpirySendOtpErrorState(
              errorMsg: (l as ServerFailure).message),
        ),
        (r) {
          final result = r.sendOTPPwdExpiryResult;
          if (result.errType.toUpperCase() == "E") {
            emit(
              PasswordExpirySendOtpErrorState(errorMsg: result.errMsg),
            );
          } else {
            emit(PasswordExpirySendOtpLoadedState(result: r));
          }
        },
      );
    }
  }

  verifyOTP(Map<String, dynamic> params) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(PasswordExpiryVerifyOtpLoadingState());
      final res = await passwordExpiryVerifyOtpUsecase.call(params);
      return res.fold(
        (l) {
          emit(PasswordExpiryVerifyOtpErrorState(
              errorMsg: (l as ServerFailure).message));
        },
        (r) {
          final result = r.verifyOTPPwdExpiryResult;
          if (result.result == "Enter valid OTP") {
            emit(
              PasswordExpiryVerifyOtpErrorState(errorMsg: result.result),
            );
          } else {
            emit(PasswordExpiryVerifyOtpLoadedState(result: r));
          }
        },
      );
    }
  }

  forgotMpin(Map<String, dynamic> params) async {
    if (await UtilsMethods().checkConnectivity()) {
      emit(
        ForgotMpinLoadingState(
          userId: params["id"],
          mobileNo: params["mobileNo"],
        ),
      );
      final res = await forgotMpinUsecase.call(params);
      return res.fold(
        (l) =>
            emit(ForgotMpinErrorState(errorMsg: (l as ServerFailure).message)),
        (r) {
          final result = r["ForgotMPinResult"].toString().split("\$");
          if (result[0].toUpperCase() == "ERROR") {
            emit(
              ForgotMpinErrorState(errorMsg: result[1].toString()),
            );
          } else {
            emit(
              ForgotMpinLoadedState(
                result: result[1],
                userId: params["id"],
                mobileNo: params["mobileNo"],
              ),
            );
          }
        },
      );
    }
  }

  forgotPwd(Map<String, dynamic> params) async {
    if (await UtilsMethods().checkConnectivity()) {
      if (params['uid'].toString().isEmpty) {
        emit(
          ForgotPwdErrorState(errorMsg: ErrorMSGConstants.kUserEmpty),
        );
      } else {
        emit(ForgotPwdLoadingState(userId: params['uid']));
        final res = await forgotPwdUsecase.call(params);
        return res.fold(
          (l) => emit(ForgotPwdErrorState(errorMsg: l.toString())),
          (r) {
            final result = r["ForgotPasswordResult"].toString().split("\$");
            if (result[0].toUpperCase() == "ERROR") {
              emit(
                ForgotPwdErrorState(errorMsg: result[1].toString()),
              );
            } else {
              emit(ForgotPwdLoadedState(
                  result: result[1], userId: params['uid']));
            }
          },
        );
      }
    }
  }

  changePassword(
      ChangePasswordValidationState state, Map<String, dynamic> params) async {
    if (await UtilsMethods().checkConnectivity()) {
      state.isLoading = true;
      emit(state);
      final res = await changePasswordUsecase.call(params);
      return res.fold(
        (l) {
          state.isLoading = false;
          state.pwdErrorTxt = (l as ServerFailure).message;
          emit(state);
        },
        (r) {
          final result = r["ChangePasswordResult"].toString().split("\$");
          if (result[0].toUpperCase() == "ERROR") {
            state.isLoading = false;
            state.pwdErrorTxt = result[1].toString();
          } else {
            state.pwdErrorTxt = result[1].toString();
          }
          emit(state);
        },
      );
    }
  }
}
