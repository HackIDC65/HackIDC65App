import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomChip extends StatelessWidget {
  final String? title;
  final Color color;
  final Color? textColor;

  CustomChip(this.title,
      {this.color = const Color(0xffffefd3), this.textColor});

  @override
  Widget build(BuildContext context) {
    var text = Text(
      title!,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            letterSpacing: 0.5,
            color: this.textColor,
          ),
    );
    if (Platform.isIOS) {
      return CupertinoButton(
        child: text,
        padding: EdgeInsets.only(left: 4, right: 4, top: 3, bottom: 3),
        minSize: 0,
        onPressed: () {},
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(3)),
      );
    }
    return Chip(
      label: text,
      padding: EdgeInsets.all(0),
      labelPadding: EdgeInsets.only(left: 4, right: 4, top: -3, bottom: -3),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
    );
  }
}

class DietIndicatorChip extends StatelessWidget {
  final String? vegan;
  final String? vegetarian;

  DietIndicatorChip({
    this.vegan,
    this.vegetarian,
  });

  @override
  Widget build(BuildContext context) {
    if (vegan != 'nope')
      return CustomChip(
        AppLocalizations.of(context)!.vegan,
        color: Color(0xff5cc471),
        textColor: Colors.white,
      );
    if (vegetarian != 'nope')
      return CustomChip(
        AppLocalizations.of(context)!.vegetarian,
        color: Color(0xff5cc471),
        textColor: Colors.white,
      );

    return CustomChip(
      AppLocalizations.of(context)!.meat,
      color: Color(0xffff5757),
      textColor: Colors.white,
    );
  }
}

class KosherIndicatorChip extends StatelessWidget {
  final int? kosher;

  KosherIndicatorChip({
    this.kosher,
  });

  @override
  Widget build(BuildContext context) {
    return CustomChip(
      "לא כשר",
      color: Color(0xff2e3035),
      textColor: Color(0xffccd3e1),
    );
  }
}
