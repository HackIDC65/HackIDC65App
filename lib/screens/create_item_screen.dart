import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/create_item_view.dart';
import 'package:flutter_app/shared/login_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CreateItemScreen extends StatefulWidget {
  final Item? item;
  final Sale sale;

  CreateItemScreen({this.item, required this.sale});

  @override
  _CreateItemScreenState createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
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
        child: CreateItemView(item: widget.item, sale: widget.sale),
      ),
    );
  }
}
