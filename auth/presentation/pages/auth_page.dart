import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sarpl/core/core.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_state.dart';
import 'package:sarpl/features/auth/presentation/widgets/set_mpin_starting_widget.dart';
import 'package:sarpl/features/customer_loan_info/presentation/cubit/customer_loan_info_cubit.dart';

import '../widgets/auth_basic_widget.dart';
import '../widgets/login_widget.dart';
import '../widgets/mpin_widget.dart';

var loginBasicInfo = LoginBasicInfo();

class AuthPage extends StatefulWidget {
  final RoutingHelper routingHelper;
  const AuthPage({super.key, required this.routingHelper});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    context.read<AuthCubit>().initialRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: SARPLColors.primaryColor,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginValidationState) {
            if (state.userNameErrorTxt.isNotEmpty) {
              UtilsMethods.callSnackbar(context, state.userNameErrorTxt);
            } else if (state.userPasswordErrorTxt.isNotEmpty) {
              UtilsMethods.callSnackbar(context, state.userPasswordErrorTxt);
            }
          } else if (state is LoginErrorState) {
            widget.routingHelper.goBack();
            UtilsMethods.callSnackbar(context, state.errMSG);
          } else if (state is LoginLoadedState) {
            widget.routingHelper.goBack();
            final loginData = state.entity.doLoginAndGetSessionIDNewResult;
            Map<String, dynamic> params = {};
            if (loginData.errorMessage.isNotEmpty) {
              if (loginData.errorMessage.toUpperCase() ==
                  ErrorResponseConstants.kPasswordExpiry.toUpperCase()) {
                DialogUtils.showCustomDialog(
                  context,
                  title: ErrorResponseConstants.kPasswordExpiry,
                  okBtnText: "OK",
                  okBtnFunction: () {
                    params = {
                      "uid": loginData.userID,
                      "mob": "",
                      "purpose": "PWD"
                    };
                    widget.routingHelper.goBack();
                    context.read<AuthCubit>().sendOTP(params);
                  },
                );
              }
            } else if (loginData.iMEIChangedFlag.toUpperCase() == "Y") {
              params = {
                "uid": loginData.userID,
                "mob": loginData.userMobile,
                "purpose": "IMEI"
              };
              context.read<AuthCubit>().sendOTP(params);
            } else {
              localStorage.setItem('user_id', loginData.userID);
              loginBasicInfo.userName = loginData.userName;
              loginBasicInfo.userId = loginData.userID;
              loginBasicInfo.unit = loginData.fOUnit;
              loginBasicInfo.sessionId = loginData.sessionID;
              loginBasicInfo.mobileNM = loginData.userMobile;
              loginBasicInfo.minMobNoRng = loginData.minMobNoRng;
              loginBasicInfo.maxMobNoRng = loginData.minMobNoRng;
              final Map<String, dynamic> params = {"UserID": loginData.userID};
              context.read<CustomerLoanInfoCubit>().getMenuDetails(params);
              widget.routingHelper
                  .navigateToAndClearStack(SARPLPageRoutes.myCustomer);
              UtilsMethods()
                  .showSaveGifProgressBar(context, StringConstants.kGetMenu);
            }
          }
          if (state is LoginLoadingState) {
            UtilsMethods()
                .showSaveGifProgressBar(context, StringConstants.kLoading);
          }
        },
        buildWhen: (prev, curr) {
          if (curr is LoginValidationState || curr is SetMPINState) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is LoginValidationState) {
            return AuthBasicWidget(
              size: size,
              requestStr: StringConstants.request,
              children: [
                CustomSegmentButton(
                  size: size,
                  state: state,
                ),
                if (state.hasLoginSwt)
                  LoginWidget(
                    state: state,
                    routingHelper: widget.routingHelper,
                  ),
                if (!state.hasLoginSwt)
                  MPINFieldWidget(
                    state: state,
                    routingHelper: widget.routingHelper,
                  ),
              ],
            );
          } else if (state is SetMPINState) {
            return AuthBasicWidget(
              size: size,
              requestStr: "Set Quick Access PIN",
              children: [
                SetForgotMpinWidget(
                  state: state,
                  routingHelper: widget.routingHelper,
                ),
              ],
            );
          } else {
            return const Text("Error");
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringConstants.appVersion,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: SARPLColors.white,
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSegmentButton extends StatelessWidget {
  final Size size;
  final LoginValidationState state;
  const CustomSegmentButton({
    super.key,
    required this.size,
    required this.state,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Expanded(
          child: SizedBox(
            width: size.width / 2.4,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  state.hasLoginSwt
                      ? SARPLColors.lightGrey
                      : SARPLColors.secondaryColor,
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              onPressed: () {
                context.read<AuthCubit>().loginMpinToggleChangeUI(state, false);
              },
              child: Text(
                StringConstants.kMpin.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: SARPLColors.black),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: size.width / 2.4,
            height: 50,
            child: TextButton(
              onPressed: () {
                context.read<AuthCubit>().loginMpinToggleChangeUI(state, true);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  state.hasLoginSwt
                      ? SARPLColors.secondaryColor
                      : SARPLColors.lightGrey,
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: Text(
                StringConstants.kLogin.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: SARPLColors.black,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
