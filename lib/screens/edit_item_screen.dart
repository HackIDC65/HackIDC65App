import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/views/edit_item_view.dart';
import 'package:flutter_app/shared/views/login_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EditItemScreen extends StatefulWidget {
  final Item? item;
  final Sale sale;

  EditItemScreen({this.item, required this.sale});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        material: (_, __) => MaterialAppBarData(elevation: 0),
        leading: Builder(
          builder: (context) => PlatformIconButton(
            icon: Image.asset("graphics/ic_back.png"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: EditItemView(item: widget.item, sale: widget.sale),
      ),
    );
  }
}
