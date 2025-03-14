import 'dart:async';

import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sarpl/core/core.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_state.dart';
import 'package:sarpl/features/auth/presentation/widgets/common_mpin_widget.dart';
import 'package:sarpl/features/auth/presentation/widgets/otp_widget.dart';

class MPINFieldWidget extends StatefulWidget {
  final RoutingHelper routingHelper;
  final LoginValidationState state;

  const MPINFieldWidget(
      {super.key, required this.state, required this.routingHelper});

  @override
  State<MPINFieldWidget> createState() => _MPINFieldWidgetState();
}

class _MPINFieldWidgetState extends State<MPINFieldWidget> {
  bool isPinSet = false;

  TextEditingController? textEditingController;

  FocusNode? node1;

  String errorText = "";

  StreamController<ErrorAnimationType>? errorAnimation =
      StreamController<ErrorAnimationType>();
  String? userId;

  @override
  void initState() {
    textEditingController = TextEditingController();
    if (localStorage.getItem('user_id') != null) {
      userId = localStorage.getItem('user_id');
    }
    node1 = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        /* if (state is LoginLoadingState) {
          UtilsMethods().showSaveGifProgressBar(context, "Loading...");
        } else 
        if (state is LoginErrorState || state is LoginLoadedState) {
          //widget.routingHelper.goBack();
          if (state is LoginErrorState) {
            if (state.errMSG.toUpperCase() ==
                ErrorResponseConstants.kPasswordExpiry.toUpperCase()) {
              DialogUtils.showCustomDialog(
                context,
                title: ErrorResponseConstants.kPasswordExpiry,
                okBtnText: "OK",
                okBtnFunction: () {
                  final Map<String, dynamic> params = {
                    "uid": userId,
                    "mob": "",
                    "purpose": "PWD"
                  };
                  widget.routingHelper.goBack();
                  context.read<AuthCubit>().sendOTP(params);
                },
              );
            }
          }
        }*/
        if (state is PasswordExpirySendOtpLoadingState) {
          UtilsMethods()
              .showSaveGifProgressBar(context, StringConstants.kLoading);
        }
        if (state is PasswordExpirySendOtpLoadedState) {
          widget.routingHelper.goBack();
          UtilsMethods().showBottomSheet(
            context,
            OTPVerifyWidget(
              routingHelper: widget.routingHelper,
              result: state.result.sendOTPPwdExpiryResult,
              userId: userId!,
              fromWidget: StringConstants.kMpin,
              credentials: {
                "userID": userId,
                "password": textEditingController!.text,
                "MPIN": "Y",
              },
            ),
          );
          /* showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            context: context,
            isDismissible: false,
            builder: (BuildContext context) {
              return OTPVerifyWidget(
                routingHelper: widget.routingHelper,
                result: state.result.sendOTPPwdExpiryResult,
                userId: userId!,
                fromWidget: StringConstants.kMpin,
                credentials: {
                  "userID": userId,
                  "password": textEditingController!.text,
                  "MPIN": "Y",
                },
              );
            },
          ); */
        }
        if (state is PasswordExpirySendOtpErrorState) {
          widget.routingHelper.goBack();
          UtilsMethods.callSnackbar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        return Column(
          spacing: 8,
          children: [
            if (userId != null && userId!.isNotEmpty)
              Text(
                userId!.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: SARPLColors.white,
                    ),
              ),
            CommonMpinWidget(
              errorAnimation: errorAnimation,
              onChanged: (val) {
                if (val.isEmpty) {
                  setState(() {
                    errorText = "";
                  });
                }
              },
              focusNode: node1,
              onCompleted: (val) {
                context.read<AuthCubit>().userLogin(
                      userId!,
                      textEditingController!.text,
                      mpin: "Y",
                    );
              },
              validator: (v) {
                if (isPinSet) {
                  if (v!.length == 4) {}
                }
                return null;
              },
              obscuringWidget: isPinSet
                  ? Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "*",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : null,
              controller: textEditingController,
              length: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButtonWidget(
                  btnTitle: StringConstants.kSetMpin,
                  onTap: () async {
                    context
                        .read<AuthCubit>()
                        .setAndForgotMpinChangeUI(widget.state);
                  },
                ),
                TextButtonWidget(
                  btnTitle: StringConstants.kForgotMpin,
                  onTap: () async {
                    context.read<AuthCubit>().setAndForgotMpinChangeUI(
                          widget.state,
                          isSetMpin: false,
                        );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
