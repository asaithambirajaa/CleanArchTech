import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AuthBasicWidget extends StatelessWidget {
  final Size size;
  final List<Widget> children;
  final String requestStr;

  const AuthBasicWidget({
    super.key,
    required this.size,
    required this.requestStr,
    required this.children,
  });
  @override
  Widget build(BuildContext context) {
    return fewCommonBodyWidget(context, size, children, requestStr);
  }

  Widget fewCommonBodyWidget(BuildContext context, Size size,
      List<Widget> children, String requestStr) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width / 2.5,
              height: size.height / 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset(SARPLAssetsConstants.banner),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              StringConstants.hello,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              requestStr,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 20),
            authCard(children),
          ],
        ),
      ),
    );
  }

  Widget authCard(List<Widget> children) {
    return Card(
      color: SARPLColors.onPrimaryColor,
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          spacing: 20,
          children: children,
        ),
      ),
    );
  }
}
