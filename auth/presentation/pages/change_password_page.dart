import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_state.dart';

import '../../../../core/core.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_basic_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  final RoutingHelper routingHelper;
  const ChangePasswordPage({super.key, required this.routingHelper});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  String userId = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      if (args != null) {
        final argLst = args.split("\$");
        userId = argLst[0];
      }
    });
    context.read<AuthCubit>().initialChangePwdRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AuthBasicWidget(
        size: size,
        requestStr: "Change Password",
        children: [
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ChangePasswordValidationState) {
                if (state.pwdErrorTxt.isNotEmpty) {
                  UtilsMethods.callSnackbar(context, state.pwdErrorTxt);
                  if (state.pwdErrorTxt == "Password Changed Successfully...") {
                    widget.routingHelper.navigateToAndClearStack(
                      SARPLPageRoutes.login,
                    );
                  }
                }
              } else if (state is ChangePasswordErrorState) {
                // widget.routingHelper.goBack();
                UtilsMethods.callSnackbar(context, state.failure.message);
              } else if (state is ChangePasswordLoadingState) {
                // UtilsMethods()
                //     .showSaveGifProgressBar(context, StringConstants.kLoading);
              }
            },
            builder: (context, state) {
              if (state is ChangePasswordValidationState) {
                return changePasswordWidget(state);
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  changePasswordWidget(ChangePasswordValidationState state) {
    oldPwdController.text = state.oldPwd;
    newPwdController.text = state.newPwd;
    confirmPwdController.text = state.confirmPwd;

    oldPwdController.selection = TextSelection.fromPosition(
      TextPosition(offset: oldPwdController.text.length),
    );
    newPwdController.selection = TextSelection.fromPosition(
      TextPosition(offset: newPwdController.text.length),
    );
    confirmPwdController.selection = TextSelection.fromPosition(
      TextPosition(offset: confirmPwdController.text.length),
    );
    return Column(
      spacing: 20,
      children: [
        SARPLCustomTextField(
          controller: oldPwdController,
          label: StringConstants.kOldPassword,
          obscureText: state.obscureTextForOld,
          suffixIcon: InkWell(
            onTap: () {
              BlocProvider.of<AuthCubit>(context).changePasswordVisibler(
                state,
                true,
                false,
                false,
              );
            },
            child: SvgPicture.asset(
              state.obscureTextForOld
                  ? SARPLAssetsConstants.eyeHideSVG
                  : SARPLAssetsConstants.eyeShowSVG,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(maxWidth: 20),
          onChanged: (value) {
            state.oldPwd = value;
          },
        ),
        SARPLCustomTextField(
          controller: newPwdController,
          label: StringConstants.kNewPassword,
          obscureText: state.obscureTextForNew,
          suffixIcon: InkWell(
            onTap: () {
              BlocProvider.of<AuthCubit>(context).changePasswordVisibler(
                state,
                false,
                true,
                false,
              );
            },
            child: SvgPicture.asset(
              state.obscureTextForNew
                  ? SARPLAssetsConstants.eyeHideSVG
                  : SARPLAssetsConstants.eyeShowSVG,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(maxWidth: 20),
          onChanged: (value) {
            state.newPwd = value;
          },
        ),
        SARPLCustomTextField(
          controller: confirmPwdController,
          label: StringConstants.kConfirmPassword,
          obscureText: state.obscureTextForCfm,
          suffixIcon: InkWell(
            onTap: () {
              BlocProvider.of<AuthCubit>(context).changePasswordVisibler(
                state,
                false,
                false,
                true,
              );
            },
            child: SvgPicture.asset(
              state.obscureTextForCfm
                  ? SARPLAssetsConstants.eyeHideSVG
                  : SARPLAssetsConstants.eyeShowSVG,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(maxWidth: 20),
          onChanged: (value) {
            state.confirmPwd = value;
          },
        ),
        RectangularButton(
          buttonTitle: StringConstants.kChangePwd.toUpperCase(),
          isLoading: state.isLoading,
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<AuthCubit>().changePwdvalidateCredentials(
                      state,
                      context,
                      state.oldPwd,
                      state.newPwd,
                      state.confirmPwd,
                      userId);
                },
        ),
      ],
    );
  }
}
