import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sarpl/features/auth/presentation/widgets/common_mpin_widget.dart';

import '../../../../core/core.dart';
import '../../domain/entities/send_otp_pwd_expiry_entity.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class OTPVerifyWidget extends StatelessWidget {
  final RoutingHelper routingHelper;
  final SendOTPPwdExpiryResultEntity result;
  final Map<String, dynamic> credentials;
  final String userId;
  final bool isIMEIChange;
  final String fromWidget;
  OTPVerifyWidget({
    super.key,
    required this.routingHelper,
    required this.result,
    required this.userId,
    this.isIMEIChange = false,
    required this.credentials,
    required this.fromWidget,
  });

  TextEditingController textEditingController = TextEditingController();
  ValueNotifier<String> otpInvalid = ValueNotifier("");

  FocusNode node1 = FocusNode();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordExpiryVerifyOtpLoadedState) {
          if (isIMEIChange) {
            context.read<AuthCubit>().userLogin(
                  credentials["userID"],
                  credentials["password"],
                  mpin: credentials["MPIN"],
                );
            routingHelper.goBack();
          } else {
            if (fromWidget == StringConstants.kLogin) {
              routingHelper.navigateToAndClearStack(
                SARPLPageRoutes.changePassword,
                arguments: "${credentials["userID"]} \$$fromWidget",
              );
            } else {
              routingHelper.navigateToAndClearStack(
                SARPLPageRoutes.changeMpin,
                arguments: "${credentials["userID"]} \$$fromWidget",
              );
            }
          }
        }
      },
      builder: (context, state) {
        isLoading = false;
        if (state is PasswordExpiryVerifyOtpLoadingState) {
          isLoading = true;
        }
        if (state is PasswordExpiryVerifyOtpErrorState) {
          otpInvalid.value = state.errorMsg;
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: UtilsMethods().getDeviceType() == DeviceType.phone
                  ? size.height / 2.6
                  : size.height / 3 + MediaQuery.of(context).viewInsets.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          routingHelper.goBack();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: SARPLColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    StringConstants.kVerifyMobNum,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: SARPLColors.white),
                  ),
                  Text(
                    StringConstants.kOTPSent,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: SARPLColors.white),
                  ),
                  CommonMpinWidget(
                    onChanged: (val) {
                      if (val.isEmpty) {}
                    },
                    focusNode: node1,
                    onCompleted: (val) {
                      textEditingController.text = val;
                    },
                    validator: (v) {
                      return null;
                    },
                    controller: textEditingController,
                    length: 6,
                  ),
                  isLoading
                      ? Center(
                          child: UtilsMethods().loadingWidget(
                              context,
                              StringConstants.kLoading,
                              MainAxisAlignment.center,
                              SARPLColors.white),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButtonWidget(
                                btnTitle: StringConstants.kResend.toUpperCase(),
                                onTap: () {
                                  otpInvalid.value = "";
                                  verifyOTP(context, isIMEIChange);
                                },
                              ),
                              TextButtonWidget(
                                btnTitle: StringConstants.kCancel.toUpperCase(),
                                onTap: () {
                                  otpInvalid.value = "";
                                  routingHelper.goBack();
                                },
                              ),
                              TextButtonWidget(
                                btnTitle: StringConstants.kSubmit.toUpperCase(),
                                onTap: () {
                                  otpInvalid.value = "";
                                  verifyOTP(context, isIMEIChange);
                                },
                              ),
                            ],
                          ),
                        ),
                  ValueListenableBuilder(
                    valueListenable: otpInvalid,
                    builder: (context, otpError, child) {
                      return Text(
                        otpError,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.redAccent,
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  verifyOTP(BuildContext context, bool isIMEIChange) {
    final Map<String, dynamic> params = {
      "PkId": result.pkId,
      "OTP": textEditingController.text,
      "userid": userId,
      "purpose": isIMEIChange ? "DID" : "PWD"
    };
    context.read<AuthCubit>().verifyOTP(params);
  }
}
