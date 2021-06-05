import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/views/item_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ItemScreen extends StatefulWidget {
  String id;
  String saleId;
  Item item;
  Sale sale;

  ItemScreen(this.id, this.saleId, {required this.item, required this.sale});

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: Builder(
          builder: (context) =>
              PlatformIconButton(
                icon: Image.asset("graphics/ic_back.png"),
                onPressed: () => Navigator.of(context).pop(),
              ),
        ),
        trailingActions: [
          Container(
              alignment: Alignment.centerRight,
              child: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return {'Edit', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
          ),
        ],
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: ItemView(widget.item, widget.sale),
      ),
    );
  }
}
