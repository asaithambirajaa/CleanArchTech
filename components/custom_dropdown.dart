import 'package:flutter/material.dart';
import 'package:sarpl/core/core.dart';

Radius textBoxBorderRadius = const Radius.circular(5);
const BorderSide textBoxBorderSide = BorderSide(
  // color: FlutterFlowTheme.of(context).secondaryText,
  color: Color(0xFFC8C8C8),

  width: 1,
);

class CustomDropdownItem<T> {
  final T item;
  final String title;
  final String? subtitle;
  CustomDropdownItem({required this.item, required this.title, this.subtitle});
}

// ignore: must_be_immutable
class CustomDropdown<T> extends StatefulWidget {
  final List<CustomDropdownItem<T>> list;
  final String hintText;
  bool isDefaultWidth;
  final ValueChanged<T> onSelectItem;
  final CustomDropdownItem<T>? initialValue;
  final bool readOnly;
  CustomDropdown({
    super.key,
    this.initialValue,
    required this.list,
    required this.hintText,
    required this.onSelectItem,
    this.readOnly = false,
    this.isDefaultWidth = true,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  CustomDropdownItem<T>? selectedItem;
  bool isDropdownOpened = false;
  double dropdownWidth = 0.0;
  double dropdownHeight = 50;
  GlobalKey dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dropdownWidth =
          (dropdownKey.currentContext!.findRenderObject() as RenderBox)
              .size
              .width;
      setState(() {});
    });
    selectedItem = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      offset: const Offset(0, 45),
      constraints: BoxConstraints(
        minWidth: dropdownWidth,
        maxWidth: dropdownWidth,
      ),
      color: SARPLColors.white,
      shadowColor: SARPLColors.secondaryBackground,
      elevation: 3,
      enabled: widget.readOnly == false,
      shape: RoundedRectangleBorder(
        side: textBoxBorderSide,
        borderRadius: BorderRadius.only(
          bottomLeft: textBoxBorderRadius,
          bottomRight: textBoxBorderRadius,
        ),
      ),
      onSelected: (T value) {
        Future.delayed(const Duration(milliseconds: 200), () {
          widget.onSelectItem(value);
          isDropdownOpened = false;
          setState(() {});
        });
      },
      onOpened: () {
        isDropdownOpened = true;
        setState(() {});
      },
      onCanceled: () {
        Future.delayed(const Duration(milliseconds: 200), () {
          isDropdownOpened = false;
          setState(() {});
        });
      },
      itemBuilder: (context) {
        return widget.list.map((e) {
          return PopupMenuItem<T>(
            onTap: () {
              selectedItem = e;
            },
            value: e.item,
            child: Container(
              color: SARPLColors.white,
              alignment: Alignment.centerLeft,
              width: dropdownWidth,
              height: dropdownHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    e.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: SARPLColors.black,
                        ),
                  ),
                  if (e.subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        e.subtitle!,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: SARPLColors.black,
                                ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        key: dropdownKey,
        width: double.infinity,
        height: dropdownHeight,
        padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
        decoration: BoxDecoration(
          color: SARPLColors.white,
          border: Border.all(
              color: textBoxBorderSide.color, width: textBoxBorderSide.width),
          borderRadius: isDropdownOpened
              ? BorderRadius.only(
                  topLeft: textBoxBorderRadius,
                  topRight: textBoxBorderRadius,
                )
              : BorderRadius.all(textBoxBorderRadius),
        ),
        child: Row(
          children: [
            Expanded(
              child: selectedItem != null
                  ? Text(
                      selectedItem!.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : Text(
                      widget.hintText,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: SARPLColors.black,
                          ),
                    ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: selectedItem != null ? Colors.black : Colors.grey,
              size: 22,
            )
          ],
        ),
      ),
    );
  }
}
