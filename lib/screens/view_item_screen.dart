import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/views/view_item_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ViewItemScreen extends StatefulWidget {
  String id;
  String saleId;
  Item item;
  Sale sale;

  ViewItemScreen(this.id, this.saleId, {required this.item, required this.sale});

  @override
  _ViewItemScreenState createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
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
            alignment: Alignment.topRight,
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return {'Edit', 'Delete'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: ViewItemView(widget.item, widget.sale),
      ),
    );
  }
}
