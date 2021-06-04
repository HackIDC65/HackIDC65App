import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/create_item_screen.dart';
import 'package:flutter_app/shared/items_list_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ViewSaleScreen extends StatefulWidget {
  String id;
  Sale sale;

  ViewSaleScreen(this.id, {required this.sale});

  ViewSaleScreen.sale(Sale fullSale)
      : this.id = fullSale.id,
        this.sale = fullSale;

  @override
  _ViewSaleScreenState createState() => _ViewSaleScreenState();
}

class _ViewSaleScreenState extends State<ViewSaleScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(widget.sale.title),
        leading: Builder(
          builder: (context) => PlatformIconButton(
            icon: Image.asset("graphics/ic_back.png"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        trailingActions: [
          PlatformIconButton(
            icon: Icon(context.platformIcons.add),
            onPressed: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (BuildContext context) {
                  return CreateItemScreen(item: null, sale: widget.sale);
                },
              ));
            },
          ),
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
        child: ItemsListView(sale: widget.sale),
      ),
    );
  }
}
