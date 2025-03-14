import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sarpl/features/auth/presentation/widgets/common_mpin_widget.dart';

import '../../../../core/core.dart';
import '../cubit/auth_state.dart';
import 'set_mpin_ending_widget.dart';

// ignore: must_be_immutable
class SetForgotMpinWidget extends StatelessWidget {
  final RoutingHelper routingHelper;
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  final SetMPINState state;

  SetForgotMpinWidget({
    super.key,
    required this.state,
    required this.routingHelper,
  });

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    bool isLoaded = false;
    bool isSetMpin = false;
    String errorTxt = "";
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is GetVerificationCodeLoadedState) {
          showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            context: context,
            isDismissible: false,
            builder: (BuildContext context) {
              return VerifyCodeWidget(
                state: state,
                routingHelper: routingHelper,
              );
            },
          );
        }
        if (state is VerifyCodeLoadedState) {
          routingHelper.goBack();
        }
        if (state is ForgotMpinErrorState) {
          UtilsMethods.callSnackbar(context, state.errorMsg);
        }
        if (state is ForgotMpinLoadedState) {
          DialogUtils.showCustomDialog(
            context,
            title: "MPIN will receive Shortly",
            okBtnText: "Close",
            okBtnFunction: () {
              context.read<AuthCubit>().initialRefresh();
              routingHelper.goBack();
            },
          );
        }
      },
      buildWhen: (pre, curr) {
        if (curr is MpinValidateState ||
            curr is MpinErrorState ||
            curr is MpinLoadedState ||
            curr is MpinLoadingState) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is CheckUserIdLoadingState) {
          isLoading = true;
          isLoaded = false;
          isSetMpin = state.isSetMpin;
          userNameController.text = state.myUserId;
        }
        if (state is CheckUserIdLoadedState) {
          isLoading = false;
          isLoaded = true;
          isSetMpin = state.isSetMpin;
          final result =
              state.result["MB_UserDetailsResult"].toString().split("\$");
          if (result.isNotEmpty) {
            userNameController.text = state.userId;
            mobileNoController.text = result[1];
          }
        }
        if (state is CheckUserIdErrorState) {
          userNameController.text = state.myUserId;
          errorTxt = state.errorMsg;
          isSetMpin = state.isSetMpin;
        }
        if (state is GetVerificationCodeLoadingState) {
          isLoading = true;
          userNameController.text = state.myUserId;
          mobileNoController.text = state.mobileNo;
        }
        if (state is GetVerificationCodeLoadedState) {
          isLoading = false;
          userNameController.text = state.userId;
          mobileNoController.text = state.mobileNo;
        }
        if (state is ForgotMpinLoadedState) {
          isLoading = false;
          userNameController.text = state.userId;
          mobileNoController.text = state.mobileNo;
        }
        if (state is ForgotMpinLoadingState) {
          isLoading = true;
          userNameController.text = state.userId;
          mobileNoController.text = state.mobileNo;
        }
        if (state is ForgotMpinErrorState) {
          isLoading = false;
        }
        userNameController.selection = TextSelection.fromPosition(
          TextPosition(offset: userNameController.text.length),
        );
        if (state is VerifyCodeLoadedState) {
          final data = state.result.completeSignUpResult;
          localStorage.setItem('user_id', state.userId);
          return SetMpinEndingWidget(
            routingHelper: routingHelper,
            sessionID: data.sessionID.toString(),
            userID: state.userId,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButtonWidget(
              btnTitle: "",
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: SARPLColors.white,
                size: 30,
              ),
              isImg: true,
              onTap: () {
                localStorage.removeItem('user_id');
                context.read<AuthCubit>().initialRefresh();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SARPLCustomTextField(
              controller: userNameController,
              maxLength: 12,
              errorText: errorTxt,
              onChanged: (value) {
                //state.userName = value;
              },
              label: StringConstants.kUserName,
              suffixIcon: (mobileNoController.text.isEmpty && isLoading)
                  ? const CupertinoActivityIndicator(
                      animating: true,
                      color: SARPLColors.primaryColor,
                    )
                  : TextButtonWidget(
                      btnTitle: "",
                      isImg: true,
                      icon: Icon(
                        Icons.check_circle_outline_outlined,
                        color: (mobileNoController.text.isNotEmpty &&
                                userNameController.text.isNotEmpty)
                            ? SARPLColors.verifiedColor
                            : SARPLColors.secondaryColor,
                        size: 30,
                        fill: 1.0,
                      ),
                      onTap: isLoaded
                          ? null
                          : () {
                              if (userNameController.text.isEmpty) {
                                UtilsMethods.callSnackbar(
                                  context,
                                  ErrorMSGConstants.kUserEmpty,
                                );
                              } else {
                                BlocProvider.of<AuthCubit>(context).checkUserId(
                                    userNameController.text,
                                    this.state.hasSetMPIN);
                              }
                            },
                    ),
              suffixIconConstraints: const BoxConstraints(maxWidth: 20),
            ),
            Visibility(
              visible: errorTxt.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text(
                  errorTxt,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.redAccent,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SARPLCustomTextField(
              controller: mobileNoController,
              label: StringConstants.kMobileNo,
              enabled: false,
            ),
            const SizedBox(
              height: 20,
            ),
            RectangularButton(
              isDisableBtn: mobileNoController.text.isEmpty ? true : false,
              buttonTitle: StringConstants.kNext.toUpperCase(),
              isLoading: (mobileNoController.text.isNotEmpty && isLoading),
              onPressed: (mobileNoController.text.isEmpty && isLoading)
                  ? null
                  : () {
                      final Map<String, dynamic> params = {
                        "id": userNameController.text,
                        "mobileNo": mobileNoController.text
                      };
                      if (isSetMpin) {
                        BlocProvider.of<AuthCubit>(context)
                            .getVerificationCode(params);
                      } else {
                        BlocProvider.of<AuthCubit>(context).forgotMpin(params);
                      }
                    },
            ),
          ],
        );
      },
    );
  }
}

class VerifyCodeWidget extends StatefulWidget {
  final RoutingHelper routingHelper;
  const VerifyCodeWidget({
    super.key,
    required this.state,
    required this.routingHelper,
  });
  final GetVerificationCodeLoadedState state;

  @override
  State<VerifyCodeWidget> createState() => _VerifyCodeWidgetState();
}

class _VerifyCodeWidgetState extends State<VerifyCodeWidget> {
  TextEditingController textEditingController = TextEditingController();

  FocusNode node1 = FocusNode();

  bool isPinSet = false;

  String errorText = "";

  @override
  void initState() {
    final result =
        widget.state.result["InitiateSignUpResult"].toString().split("\$");
    textEditingController.text = result[1];
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    node1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is VerifyCodeErrorState) {
          errorText = state.errorMsg;
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  widget.routingHelper.goBack();
                },
                icon: const Icon(
                  Icons.close,
                  color: SARPLColors.secondaryColor,
                ),
              ),
              CommonMpinWidget(
                onChanged: (val) {
                  if (val.isEmpty) {}
                },
                focusNode: node1,
                onCompleted: (val) {},
                validator: (v) {
                  if (isPinSet) {
                    if (v!.length == 6) {}
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
                length: 6,
              ),
              Visibility(
                visible: isPinSet,
                child: Text(
                  ErrorMSGConstants.kVerificationCodeLengthMSG,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.redAccent,
                      ),
                ),
              ),
              Visibility(
                visible: errorText.isNotEmpty,
                child: Text(
                  errorText,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.redAccent,
                      ),
                ),
              ),
              TextButtonWidget(
                btnTitle: StringConstants.kResendCode,
                onTap: () async {
                  final Map<String, dynamic> params = {
                    "id": widget.state.userId,
                    "mobileNo": widget.state.mobileNo
                  };
                  BlocProvider.of<AuthCubit>(context)
                      .getVerificationCode(params);
                  widget.routingHelper.goBack();
                },
              ),
              SizedBox(
                width: 80,
                child: RectangularButton(
                  buttonTitle: StringConstants.kNext.toUpperCase(),
                  isLoading: (state is VerifyCodeLoadingState),
                  onPressed: () {
                    if (textEditingController.text.isEmpty ||
                        textEditingController.text.length < 6) {
                      setState(
                        () {
                          isPinSet = true;
                        },
                      );
                    } else {
                      final Map<String, dynamic> params = {
                        "otpnumber": textEditingController.text,
                        "UserID": widget.state.userId
                      };
                      BlocProvider.of<AuthCubit>(context).verifyCode(params);
                      setState(
                        () {
                          isPinSet = false;
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
