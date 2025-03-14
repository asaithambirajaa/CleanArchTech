import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

import '../core.dart';

class RectangularButton extends StatelessWidget {
  final String buttonTitle;
  final bool isDisableBtn;
  final bool isLoading;
  final void Function()? onPressed;
  const RectangularButton({
    super.key,
    this.onPressed,
    required this.buttonTitle,
    this.isDisableBtn = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 80,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            isDisableBtn ? SARPLColors.lightGrey : SARPLColors.secondaryColor,
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          elevation: WidgetStateProperty.all(4),
        ),
        child: isLoading
            ? const CupertinoActivityIndicator(
                animating: true,
                color: SARPLColors.black,
              )
            : Text(
                buttonTitle,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color:
                          isDisableBtn ? SARPLColors.white : SARPLColors.black,
                    ),
              ),
      ),
    );
  }
}

class AnimateButton extends StatelessWidget {
  final bool isLoading;
  final String btnTitle;
  final void Function()? onPressed;
  const AnimateButton({
    super.key,
    required this.isLoading,
    required this.btnTitle,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          SARPLColors.secondaryColor,
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        elevation: WidgetStateProperty.all(4),
      ),
      child: isLoading
          ? const CupertinoActivityIndicator(
              animating: true,
              color: SARPLColors.black,
            )
          : Text(
              btnTitle,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: SARPLColors.black,
                  ),
            ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final String btnTitle;
  final bool isImg;
  final Icon? icon;
  const TextButtonWidget({
    super.key,
    this.onTap,
    required this.btnTitle,
    this.isImg = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isImg
          ? icon
          : Text(
              btnTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: SARPLColors.white),
            ),
    );
  }
}
