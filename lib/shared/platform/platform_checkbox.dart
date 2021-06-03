import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PlatformCheckBox extends PlatformWidgetBase<Widget, Checkbox> {
  final double size;
  final bool selected;
  final void Function(bool?)? onChange;

  const PlatformCheckBox({
    Key? key,
    this.size = 24,
    this.selected = false,
    this.onChange,
  });

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: PlatformIconButton(
        icon: Icon(
          selected
              ? CupertinoIcons.check_mark_circled_solid
              : CupertinoIcons.circle,
          size: size,
          color: Colors.grey,
        ),
        padding: EdgeInsets.zero,
        onPressed: onChange == null ? null : () => onChange!(!selected),
      ),
    );
  }

  @override
  Checkbox createMaterialWidget(BuildContext context) {
    return Checkbox(
      value: selected,
      onChanged: onChange,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
