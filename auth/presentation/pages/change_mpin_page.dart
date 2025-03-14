import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_state.dart';
import 'package:sarpl/features/auth/presentation/widgets/auth_basic_widget.dart';
import 'package:sarpl/features/auth/presentation/widgets/common_mpin_widget.dart';

import '../../../../core/core.dart';
import '../cubit/auth_cubit.dart';

class ChangeMpinPage extends StatefulWidget {
  final RoutingHelper routingHelper;
  const ChangeMpinPage({super.key, required this.routingHelper});

  @override
  State<ChangeMpinPage> createState() => _ChangeMpinPageState();
}

class _ChangeMpinPageState extends State<ChangeMpinPage> {
  bool isPinSet1 = false;
  bool isPinSet2 = false;
  bool isPinSet3 = false;

  TextEditingController? oldMpinController;
  TextEditingController? newMpinController;
  TextEditingController? cfmMpinController;

  FocusNode? node1;
  FocusNode? node2;
  FocusNode? node3;

  String errorText = "";

  StreamController<ErrorAnimationType>? errorAnimation1 =
      StreamController<ErrorAnimationType>();
  StreamController<ErrorAnimationType>? errorAnimation2 =
      StreamController<ErrorAnimationType>();
  StreamController<ErrorAnimationType>? errorAnimation3 =
      StreamController<ErrorAnimationType>();
  String userId = "";
  String fromWidget = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      if (args != null) {
        final argLst = args.split("\$");
        userId = argLst[0];
        fromWidget = argLst[1];
      }
    });
    context.read<AuthCubit>().initialChangeMpinRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AuthBasicWidget(
        size: size,
        requestStr: StringConstants.kChangeMpin,
        children: [
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ChangeMpinValidationState) {
                if (state.mpinErrorTxt.isNotEmpty) {
                  UtilsMethods.callSnackbar(context, state.mpinErrorTxt);
                  if (state.mpinErrorTxt ==
                      "Password Changed Successfully...") {
                    widget.routingHelper.navigateToAndClearStack(
                      SARPLPageRoutes.login,
                    );
                    if (fromWidget == StringConstants.kLogin) {
                      //TODO: Check and implement
                      // context.read<AuthCubit>().initialRefresh();
                    }
                  }
                }
              } else if (state is ChangeMpinErrorState) {
                // widget.routingHelper.goBack();
                UtilsMethods.callSnackbar(context, state.failure.message);
              }
            },
            builder: (context, state) {
              if (state is ChangeMpinValidationState) {
                return mpinChangeWidget(state);
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  mpinChangeWidget(ChangeMpinValidationState state) {
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        placeholderTxtWidget("Old Mpin"),
        CommonMpinWidget(
          errorAnimation: errorAnimation1,
          onChanged: (val) {
            if (val.isEmpty) {
              setState(() {
                errorText = "";
              });
            }
          },
          focusNode: node1,
          onCompleted: (val) {
            state.oldMpin = val;
          },
          validator: (v) {
            if (isPinSet1) {
              if (v!.length == 4) {}
            }
            return null;
          },
          obscuringWidget: isPinSet1
              ? Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "*",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : null,
          controller: oldMpinController,
          length: 4,
        ),
        placeholderTxtWidget("New Mpin"),
        CommonMpinWidget(
          errorAnimation: errorAnimation3,
          onChanged: (val) {
            if (val.isEmpty) {
              setState(() {
                errorText = "";
              });
            }
          },
          focusNode: node2,
          onCompleted: (val) {
            state.newMpin = val;
          },
          validator: (v) {
            if (isPinSet2) {
              if (v!.length == 4) {}
            }
            return null;
          },
          obscuringWidget: isPinSet2
              ? Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "*",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : null,
          controller: newMpinController,
          length: 4,
        ),
        placeholderTxtWidget("Confirm Mpin"),
        CommonMpinWidget(
          errorAnimation: errorAnimation3,
          onChanged: (val) {
            if (val.isEmpty) {
              setState(() {
                errorText = "";
              });
            }
          },
          focusNode: node3,
          onCompleted: (val) {
            state.confirmMpin = val;
          },
          validator: (v) {
            if (isPinSet3) {
              if (v!.length == 4) {}
            }
            return null;
          },
          obscuringWidget: isPinSet3
              ? Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "*",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : null,
          controller: cfmMpinController,
          length: 4,
        ),
        RectangularButton(
          buttonTitle: StringConstants.kChangeMpin.toUpperCase(),
          isLoading: state.isLoading,
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<AuthCubit>().changeMpinvalidateCredentials(
                        state,
                        context,
                        state.oldMpin,
                        state.newMpin,
                        state.confirmMpin,
                        userId,
                      );
                },
        ),
      ],
    );
  }

  placeholderTxtWidget(String txt) {
    return Text(
      txt,
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(color: SARPLColors.white),
    );
  }
}
