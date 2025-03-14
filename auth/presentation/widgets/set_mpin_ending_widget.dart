import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_state.dart';
import 'package:sarpl/features/auth/presentation/widgets/common_mpin_widget.dart';

import '../../../../core/core.dart';

class SetMpinEndingWidget extends StatefulWidget {
  final RoutingHelper routingHelper;
  final String userID;
  final String sessionID;
  const SetMpinEndingWidget({
    super.key,
    required this.routingHelper,
    required this.userID,
    required this.sessionID,
  });

  @override
  State<SetMpinEndingWidget> createState() => _SetMpinEndingWidgetState();
}

class _SetMpinEndingWidgetState extends State<SetMpinEndingWidget> {
  bool isPinSet = false;
  String newPin = "";
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textConfirmPin = TextEditingController();

  FocusNode? node1;
  FocusNode? node2;

  String errorText = "";

  MpinValidateState state = MpinValidateState();

  @override
  void initState() {
    textEditingController = TextEditingController();
    textConfirmPin = TextEditingController();

    node1 = FocusNode();
    node2 = FocusNode();
    state = MpinValidateState();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    textConfirmPin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is MpinValidateState) {
          UtilsMethods.callSnackbar(context, state.errorMsg);
        }
        if (state is MpinErrorState) {
          UtilsMethods.callSnackbar(context, state.errorMsg);
        }
        if (state is MpinLoadedState) {
          UtilsMethods.callSnackbar(context, state.result);
          context.read<AuthCubit>().initialRefresh();
        }
      },
      listenWhen: (pre, curr) {
        if (curr is MpinValidateState) {
          if (curr.errorMsg.isNotEmpty) {
            return true;
          }
        } else if (curr is MpinErrorState) {
          if (curr.errorMsg.isNotEmpty) {
            return true;
          }
        } else if (curr is MpinLoadedState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButtonWidget(
              btnTitle: '',
              isImg: true,
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: SARPLColors.white,
                size: 30,
              ),
              onTap: () {
                context.read<AuthCubit>().initialRefresh();
              },
            ),
            Text(
              StringConstants.kNewMpin,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: SARPLColors.white,
                  ),
            ),
            CommonMpinWidget(
              onChanged: (val) {
                if (val.isNotEmpty) {
                  this.state.newMpin = val;
                }
              },
              focusNode: node1,
              onCompleted: (val) {
                final isSequence = UtilsMethods().setMpinErrorMpin(val);
                final params = requestParams();
                context.read<AuthCubit>().validateMpin(
                      this.state,
                      context,
                      textEditingController.text,
                      textConfirmPin.text,
                      params,
                      isSequenceCheck: isSequence,
                    );
                FocusScope.of(context).requestFocus(node1);
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
            Text(
              StringConstants.kConfirmMpin,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: SARPLColors.white,
                  ),
            ),
            CommonMpinWidget(
              onChanged: (val) {
                if (val.isNotEmpty) {
                  this.state.confiMpin = val;
                }
              },
              focusNode: node2,
              onCompleted: (val) {
                final isSequence = UtilsMethods().setMpinErrorMpin(val);
                context.read<AuthCubit>().validateMpin(
                      this.state,
                      context,
                      textEditingController.text,
                      textConfirmPin.text,
                      requestParams(),
                      isSequenceCheck: isSequence,
                    );

                FocusScope.of(context).requestFocus(node2);
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
              controller: textConfirmPin,
              length: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 80,
                  child: RectangularButton(
                    buttonTitle: StringConstants.kNext.toUpperCase(),
                    isLoading: (state is MpinLoadingState),
                    onPressed: (state is MpinLoadingState)
                        ? null
                        : () {
                            context.read<AuthCubit>().validateMpin(
                                  this.state,
                                  context,
                                  textEditingController.text,
                                  textConfirmPin.text,
                                  requestParams(),
                                  isSequenceCheck: false,
                                );
                          },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Map<String, dynamic> requestParams() {
    final Map<String, dynamic> params = {
      "UserID": widget.userID,
      "OldMPin": "",
      "NewMPin": textEditingController.text,
      "ConfirmMPin": textConfirmPin.text,
      "SetForgotUpdate": "S",
      "SessionID": widget.sessionID,
    };
    return params;
  }
}
