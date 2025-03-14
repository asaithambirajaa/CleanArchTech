import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/core.dart';

class CommonMpinWidget extends StatelessWidget {
  final StreamController<ErrorAnimationType>? errorAnimation;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final Widget? obscuringWidget;
  final FocusNode? focusNode;
  final int length;
  const CommonMpinWidget({
    super.key,
    this.errorAnimation,
    this.controller,
    this.onChanged,
    this.onCompleted,
    this.validator,
    this.obscuringWidget,
    this.focusNode,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      cursorColor: SARPLColors.white,
      textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: SARPLColors.white,
          ),
      // errorAnimationController: errorAnimation,
      errorAnimationDuration: 1,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      enableActiveFill: false,
      mainAxisAlignment: MainAxisAlignment.center,
      showCursor: false,
      obscureText: false,
      autoFocus: true,
      focusNode: focusNode,
      autoDisposeControllers: false,
      obscuringCharacter: ' ',
      animationType: AnimationType.none,
      onCompleted: onCompleted,
      validator: validator,
      obscuringWidget: obscuringWidget,
      keyboardType: TextInputType.number,
      controller: controller,
      pinTheme: PinTheme(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
        borderWidth: 1,
        shape: PinCodeFieldShape.box,
        fieldHeight: 70,
        fieldWidth: 70,
        activeColor: SARPLColors.white,
        inactiveFillColor: SARPLColors.primaryColor,
        inactiveColor: SARPLColors.primaryColor,
        selectedColor: SARPLColors.secondaryColor,
        activeFillColor: SARPLColors.white,
        selectedFillColor: SARPLColors.onSecondaryColor,
        fieldOuterPadding: const EdgeInsets.all(8.0),
      ),
      appContext: context,
      length: length,
    );
  }
}
