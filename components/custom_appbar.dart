import 'package:flutter/material.dart';
import 'package:sarpl/core/core.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onBack;
  final String titleText;
  final bool hideBackBtn;

  const CustomAppBar({
    this.hideBackBtn = false,
    required this.onBack,
    Key? key,
    required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                SARPLColors.primaryColor,
                SARPLColors.primaryColor,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 6.0, bottom: 6.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0.0,
              leading: GestureDetector(
                onTap: onBack,
                child: hideBackBtn
                    ? const Icon(
                        Icons.menu,
                        size: 32,
                        color: SARPLColors.white,
                      )
                    : const Icon(
                        Icons.arrow_back_ios_new,
                        size: 32,
                        color: SARPLColors.white,
                      ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  titleText,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: SARPLColors.white,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
