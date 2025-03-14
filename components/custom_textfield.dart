import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sarpl/core/core.dart';

class SARPLCustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color borderColor;
  final Color textColor;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? label;
  final Widget? suffixIcon;
  final Widget? suffix;
  final BoxConstraints? suffixIconConstraints;
  final int? maxLength;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool? enabled;
  final Color bgColor;
  final double? cursorHeight;
  final double? cursorWidth;
  final String? prefixText;
  final String? suffixText;
  final BoxConstraints? prefixIconConstraints;
  final String? hintText;
  final bool? enableInteractiveSelection;
  final bool readOnly;
  final bool obscureText;
  final Widget? prefixIcon;
  final String errorText;
  final bool visible;
  final bool mandatoryField;
  final int? maxLines;
  final String? counterText;
  final bool? alignLabelWithHint;
  final String? obscuringCharacter;
  final TextCapitalization textCapitalization;
  final EdgeInsets? scrollPadding;

  const SARPLCustomTextField({
    Key? key,
    this.borderColor = Colors.black45,
    this.textColor = Colors.black,
    this.bgColor = Colors.white,
    this.controller,
    this.focusNode,
    this.suffix,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.prefixIcon,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.label,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.enabled,
    this.cursorHeight,
    this.cursorWidth,
    this.textInputAction,
    this.scrollPadding,
    this.prefixText,
    this.suffixText,
    this.suffixIcon,
    this.maxLines,
    this.alignLabelWithHint,
    this.obscuringCharacter,
    this.textCapitalization = TextCapitalization.none,
    this.enableInteractiveSelection = true,
    this.readOnly = false,
    this.obscureText = false,
    this.errorText = "",
    this.counterText,
    this.visible = false,
    this.mandatoryField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mywidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: ShapeDecoration(
            color: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                width: 1.0,
                color: borderColor,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 14.0, 0.0),
            child: TextField(
              enabled: enabled,
              controller: controller,
              scrollPadding: scrollPadding != null
                  ? scrollPadding!
                  : const EdgeInsets.only(bottom: 100),
              focusNode: focusNode,
              enableInteractiveSelection: enableInteractiveSelection,
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              maxLength: maxLength,
              maxLines: maxLines ?? 1,
              cursorColor: Colors.black,
              readOnly: readOnly,
              obscureText: obscureText,
              textCapitalization: textCapitalization,
              obscuringCharacter: obscuringCharacter ?? '.',
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                alignLabelWithHint: alignLabelWithHint,
                hintText: hintText,
                suffixIcon: suffixIcon ?? const SizedBox(),
                prefixIcon: prefixIcon,
                prefixText: prefixText,
                suffixText: suffixText,
                suffixIconColor: Theme.of(context).colorScheme.inversePrimary,
                suffix: suffix,
                suffixIconConstraints: suffixIconConstraints,
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                prefixIconConstraints: prefixIconConstraints,
                border: InputBorder.none,
                label: RichText(
                  text: TextSpan(
                    text: label,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: SARPLColors.black,
                        ),
                    children: [
                      TextSpan(
                        text: mandatoryField ? "*" : "",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onError,
                            ),
                      ),
                    ],
                  ),
                ),
                counterText: "",
              ),
              onTap: () async {
                if (onTap != null) {
                  onTap!();
                }
              },
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
            ),
          ),
        ),
        Visibility(
          visible: visible,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              errorText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onError,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
