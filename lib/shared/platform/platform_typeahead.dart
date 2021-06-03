import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_typeahead/cupertino_flutter_typeahead.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CupertinoTypeAheadData {
  final CupertinoSuggestionsBoxController? suggestionsBoxController;
  final BoxDecoration? decoration;

  const CupertinoTypeAheadData({
    this.suggestionsBoxController,
    this.decoration,
  });
}

class MaterialTypeAheadData {
  final SuggestionsBoxController? suggestionsBoxController;
  final InputDecoration? decoration;

  const MaterialTypeAheadData({
    this.suggestionsBoxController,
    this.decoration,
  });
}

class PlatformTypeAhead<T>
    extends PlatformWidgetBase<CupertinoTypeAheadField, TypeAheadField> {
  final FutureOr<Iterable<T>>? Function(String)? suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(dynamic)? onSuggestionSelected;
  final TextEditingController? controller;
  final bool autofocus;
  final TextStyle? textStyle;
  final bool? getImmediateSuggestions;

  final MaterialTypeAheadData Function(BuildContext, dynamic)? material;
  final CupertinoTypeAheadData Function(BuildContext, dynamic)? cupertino;

  const PlatformTypeAhead({
    Key? key,
    this.suggestionsCallback,
    required this.itemBuilder,
    this.onSuggestionSelected,
    this.controller,
    this.autofocus = false,
    this.textStyle,
    this.getImmediateSuggestions,
    this.material,
    this.cupertino,
  });

  @override
  CupertinoTypeAheadField createCupertinoWidget(BuildContext context) {
    var data =
        cupertino == null ? CupertinoTypeAheadData() : cupertino!(context, null);
    return CupertinoTypeAheadField(
      textFieldConfiguration: CupertinoTextFieldConfiguration(
        controller: controller,
        autofocus: autofocus,
        style: textStyle,
        decoration: data.decoration!,
        suffix: Row(
          children: [
            Container(
              color: Colors.grey,
              width: 1,
              height: 10,
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
            SizedBox(width: 4),
          ],
        ),
      ),
      getImmediateSuggestions: getImmediateSuggestions!,
      suggestionsBoxController: data.suggestionsBoxController,
      suggestionsCallback: suggestionsCallback as FutureOr<Iterable<dynamic>> Function(String),
      itemBuilder: itemBuilder as Widget Function(BuildContext, dynamic),
      onSuggestionSelected: onSuggestionSelected!,
    );
  }

  @override
  TypeAheadField createMaterialWidget(BuildContext context) {
    var data =
        material == null ? MaterialTypeAheadData() : material!(context, null);

    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        autofocus: autofocus,
        style: textStyle,
        decoration: data.decoration ?? const InputDecoration(),

      ),
      getImmediateSuggestions: getImmediateSuggestions!,
      suggestionsCallback: suggestionsCallback as FutureOr<Iterable<dynamic>> Function(String),
      suggestionsBoxController: data.suggestionsBoxController,
      itemBuilder: itemBuilder as Widget Function(BuildContext, dynamic),
      onSuggestionSelected: onSuggestionSelected!,
    );
  }
}
