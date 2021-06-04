import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/create_item_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/items_list_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:share/share.dart';

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
            icon: Image.asset("graphics/ic_back.png"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        material: (_, __) => MaterialAppBarData(elevation: 0),
        trailingActions: [
          PlatformIconButton(
            icon: Icon(context.platformIcons.share),
            onPressed: () {
              Share.share('Check out my new sale https://sales-now.com/${widget.sale.id}');
            },
          ),
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
              )),
        ],
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: Stack(
          children: [
            ItemsListView(sale: widget.sale),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FilledButton.text(
                  'ADD ITEM',
                  width: double.infinity,
                  onPressed: () {
                    Navigator.of(context).push(platformPageRoute(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateItemScreen(item: null, sale: widget.sale);
                      },
                    ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
