import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
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
        leading: Builder(
          builder: (context) => PlatformIconButton(
            icon: Icon(Icons.keyboard_return_rounded), //Image.asset("graphics/ic_back.png"),
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
              )
          ),
        ],
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: ItemsListView(),
      ),
    );
  }
}
