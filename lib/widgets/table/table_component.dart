import 'package:flutter/material.dart';
import '/theme/app_colors.dart';
import '/theme/app_text_theme.dart';

DataCell rowCellData({
  String? title,
  Widget? child,
  AlignmentGeometry alignment = Alignment.centerLeft,
}) {
  Widget cellChild;
  if (child != null) {
    cellChild = child;
  } else {
    cellChild = Padding(
      padding: alignment != Alignment.centerLeft
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: alignment,
        child: Text(
          title!,
        ),
      ),
    );
  }
  return DataCell(cellChild);
}

Widget tableCellText({
  String? title,
  Widget? child,
  TextStyle? style,
  AlignmentGeometry alignment = Alignment.centerLeft,
}) {
  return Container(
    constraints: const BoxConstraints(minHeight: 40),
    child: child ??
        Padding(
          padding: alignment != Alignment.centerLeft
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: alignment,
            child: Text(
              title!,
              style: style ?? AppTextTheme.normalText(AppColor.black),
            ),
          ),
        ),
  );
}

Widget tableCellOnHover({
  required Widget child,
  required Widget Function(dynamic Function()?) onHoverChild,
  double onHoverChildTopPadding = 0,
}) {
  late OverlayEntry _overlayEntry;
  return LayoutBuilder(builder: (cellContext, size) {
    return MouseRegion(
      child: child,
      onEnter: (value) {
        RenderBox renderBox = cellContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        _overlayEntry = OverlayEntry(
          builder: (context) {
            return Positioned(
              top: position.dy,
              left: position.dx,
              child: Material(
                color: Colors.transparent,
                child: MouseRegion(
                  onExit: (value) {
                    _overlayEntry.remove();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: renderBox.size.height),
                    child: onHoverChild(() {
                      _overlayEntry.remove();
                    }),
                  ),
                ),
              ),
            );
          },
        );
        Overlay.of(cellContext)!.insert(_overlayEntry);
      },
    );
  });
}

class TableHeader {
  final String title;
  final double width;
  final bool isConstant;

  TableHeader({
    required this.title,
    required this.width,
    this.isConstant = false,
  });
}

class TableHeaderButton {
  final String title;
  final Function()? onPressed;
  TableHeaderButton({
    required this.title,
    required this.onPressed,
  });
}
