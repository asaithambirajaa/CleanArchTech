import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sarpl/core/core.dart';
import 'package:sarpl/features/auth/presentation/widgets/otp_widget.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginWidget extends StatelessWidget {
  final RoutingHelper routingHelper;
  LoginWidget({super.key, required this.state, required this.routingHelper});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LoginValidationState state;
  bool isLoading = false;
  bool iMEIChangedFlag = false;
  String userId = "";

  @override
  Widget build(BuildContext context) {
    userNameController.text = state.userName;
    passwordController.text = state.password;

    userNameController.selection = TextSelection.fromPosition(
      TextPosition(offset: userNameController.text.length),
    );
    passwordController.selection = TextSelection.fromPosition(
      TextPosition(offset: passwordController.text.length),
    );
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadedState) {
          final loginData = state.entity.doLoginAndGetSessionIDNewResult;
          userId = loginData.userID;
          iMEIChangedFlag = false;
          if (loginData.iMEIChangedFlag.toUpperCase() == "Y") {
            iMEIChangedFlag = true;
          }
        }
        if (state is PasswordExpirySendOtpLoadingState) {
          UtilsMethods()
              .showSaveGifProgressBar(context, StringConstants.kLoading);
        }
        if (state is PasswordExpirySendOtpLoadedState) {
          routingHelper.goBack();
          UtilsMethods().showBottomSheet(
            context,
            OTPVerifyWidget(
              routingHelper: routingHelper,
              result: state.result.sendOTPPwdExpiryResult,
              userId: userId,
              isIMEIChange: iMEIChangedFlag,
              fromWidget: StringConstants.kLogin,
              credentials: {
                "userID": userNameController.text,
                "password": passwordController.text,
                "MPIN": "N",
              },
            ),
          );
          /* showModalBottomSheet<dynamic>(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (BuildContext context) {
              return OTPVerifyWidget(
                routingHelper: routingHelper,
                result: state.result.sendOTPPwdExpiryResult,
                userId: userId,
                isIMEIChange: iMEIChangedFlag,
                fromWidget: StringConstants.kLogin,
                credentials: {
                  "userID": userNameController.text,
                  "password": passwordController.text,
                  "MPIN": "N",
                },
              );
            },
          ); */
        }
        if (state is PasswordExpirySendOtpErrorState) {
          routingHelper.goBack();
          UtilsMethods.callSnackbar(context, state.errorMsg);
        }
        if (state is ForgotPwdErrorState) {
          routingHelper.goBack();
          UtilsMethods.callSnackbar(context, state.errorMsg);
        }
        if (state is ForgotPwdLoadingState) {
          UtilsMethods()
              .showSaveGifProgressBar(context, StringConstants.kLoading);
        }
        if (state is ForgotPwdLoadedState) {
          routingHelper.goBack();
          UtilsMethods.callSnackbar(context, state.result);
        }
      },
      builder: (context, state) {
        isLoading = false;
        if (state is LoginLoadingState) {
          isLoading = true;
        }
        return Column(
          spacing: 20,
          children: [
            SARPLCustomTextField(
              controller: userNameController,
              maxLength: 12,
              onChanged: (value) {
                this.state.userName = value;
              },
              label: StringConstants.kUserName,
              suffixIcon: SvgPicture.asset(SARPLAssetsConstants.userNameSVG),
              suffixIconConstraints: const BoxConstraints(maxWidth: 20),
            ),
            SARPLCustomTextField(
              controller: passwordController,
              label: StringConstants.kPassword,
              obscureText: this.state.obscureText,
              suffixIcon: InkWell(
                onTap: () {
                  BlocProvider.of<AuthCubit>(context)
                      .passwordVisibler(this.state);
                },
                child: SvgPicture.asset(
                  this.state.obscureText
                      ? SARPLAssetsConstants.eyeHideSVG
                      : SARPLAssetsConstants.eyeShowSVG,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(maxWidth: 20),
              onChanged: (value) {
                this.state.password = value;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButtonWidget(
                  btnTitle: StringConstants.kForgotPassword,
                  onTap: () {
                    final Map<String, dynamic> params = {
                      "uid": this.state.userName
                    };
                    context.read<AuthCubit>().forgotPwd(params);
                  },
                ),
              ],
            ),
            RectangularButton(
              buttonTitle: StringConstants.kLogin.toUpperCase(),
              isLoading: isLoading,
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<AuthCubit>().validateCredentials(
                            this.state,
                            context,
                            this.state.userName,
                            this.state.password,
                            "N",
                          );
                    },
            ),
          ],
        );
      },
    );
  }
}
