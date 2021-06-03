import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/platform/platform_checkbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'loader.dart';

class MultiSelect<T> extends StatefulWidget {
  final Future<List<T>>? options;
  final Text Function(BuildContext, T) itemBuilder;
  final List<T>? selected;
  final Function(List<T>)? onSelectionChanged;
  final int maxOptionsShown;

  MultiSelect({
    this.options,
    required this.itemBuilder,
    this.selected,
    this.onSelectionChanged,
    this.maxOptionsShown = 10,
  });

  @override
  _MultiSelectState createState() => _MultiSelectState<T>();
}

class _MultiSelectState<T> extends State<MultiSelect<T>> {
  late Set<T> selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    selected = Set.from(widget.selected ?? []);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: widget.options,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("something went wrong");
        } else if (snapshot.hasData) {
          return Column(
            children: [
              for (T item in snapshot.data!.take(widget.maxOptionsShown))
                SizedBox(
                  height: 24,
                  child: FilledButton(
                    padding: EdgeInsets.zero,
                    color: Colors.transparent,
                    height: double.nan,
                    child: Row(
                      children: [
                        PlatformCheckBox(
                          selected: selected.contains(item),
                          onChange: (value) {
                            setState(() {
                              if (selected.contains(item))
                                selected.remove(item);
                              else
                                selected.add(item);
                            });

                            widget.onSelectionChanged!(List.from(selected));
                          },
                        ),
                        Flexible(child: widget.itemBuilder(context, item)),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        if (selected.contains(item))
                          selected.remove(item);
                        else
                          selected.add(item);
                      });

                      widget.onSelectionChanged!(List.from(selected));
                    },
                  ),
                ),
              if (snapshot.data!.length > widget.maxOptionsShown)
                SizedBox(
                  height: 24,
                  child: FilledButton(
                    padding: EdgeInsets.zero,
                    color: Colors.transparent,
                    height: double.nan,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                        ),
                        Text(
                          AppLocalizations.of(context)!.moreOptionsText(
                              (snapshot.data!.length - widget.maxOptionsShown)
                                  .toString()),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                )
            ],
          );
        } else {
          return Loader();
        }
      },
    );
  }
}
