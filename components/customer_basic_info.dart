import 'package:flutter/material.dart';

import '../core.dart';

class CustomerBasicInfo extends StatelessWidget {
  final String customerName;
  final String customerMn;
  final String loanNo;
  final Color? cardColor;
  final Color? txtColor;
  final Color? borderColor;
  final Color? containerColor;
  const CustomerBasicInfo({
    super.key,
    required this.customerName,
    required this.customerMn,
    required this.loanNo,
    this.cardColor,
    this.txtColor,
    this.borderColor,
    this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor ?? SARPLColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: Container(
          decoration: BoxDecoration(
            color: containerColor ?? SARPLColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
            border: Border(
              left:
                  BorderSide(color: borderColor ?? SARPLColors.white, width: 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 12,
              children: [
                const Icon(
                  Icons.person,
                  size: 80,
                  color: SARPLColors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: txtColor ?? SARPLColors.white),
                    ),
                    Text(
                      customerMn,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: txtColor ?? SARPLColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      loanNo,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: txtColor ?? SARPLColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
