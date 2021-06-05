import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FilledButton extends StatefulWidget {
  final Widget? child;
  final Color color;
  final Color disabledColor;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final shadow;
  final Color? shadowColor;
  final dynamic padding;
  final double? minWidth;

  FilledButton({
    this.child,
    this.color = const Color(0Xffffbf00),
    this.disabledColor = Colors.transparent,
    this.onPressed,
    this.width,
    this.shadow,
    this.shadowColor,
    this.padding,
    this.height,
    this.borderRadius,
    this.minWidth,
    this.border,
  });

  FilledButton.text(
    String text, {
    this.color = const Color(0Xffffbf00),
    this.disabledColor = Colors.transparent,
    this.onPressed,
    this.width,
    this.height,
    this.shadow,
    this.shadowColor,
    this.padding,
    Widget? icon,
    TextStyle? textStyle,
    this.borderRadius,
    this.minWidth,
    this.border,
  }) : this.child = __buildTextChild(text, textStyle, icon);

  @override
  _FilledButtonState createState() => _FilledButtonState();

  static Widget __buildTextChild(String text, TextStyle? textStyle, icon) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 4.0),
            child: icon,
          ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}

class _FilledButtonState extends State<FilledButton> {
  @override
  Widget build(BuildContext context) {
    double? height = (widget.height ?? 48);
    if (height.isNaN) height = null;

    var btn = Container(
      height: height,
      width: widget.width,
      child: PlatformButton(
        disabledColor: widget.disabledColor,
        color: widget.color,
        padding: widget.padding ??
            EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 2,
            ),
        materialFlat: (_, __) => MaterialFlatButtonData(
          minWidth: widget.minWidth,
          shape: widget.borderRadius != null
              ? RoundedRectangleBorder(borderRadius: widget.borderRadius!)
              : null,
        ),
        cupertino: (_, __) => CupertinoButtonData(
          borderRadius: __safeBorderRadius(widget.borderRadius),
        ),
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );

    if (widget.shadow != null || widget.border != null)
      return Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: widget.border,
          boxShadow: widget.shadow != null ? [
            BoxShadow(
              color: widget.shadowColor ?? Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ] : [],
        ),
        child: btn,
      );

    return btn;
  }

  BorderRadius? __safeBorderRadius(BorderRadiusGeometry? borderRadius) {
    if (widget.borderRadius == null ||
        widget.borderRadius is! BorderRadiusDirectional)
      return widget.borderRadius as BorderRadius?;
    return widget.borderRadius!.resolve(Directionality.of(context));
  }
}
