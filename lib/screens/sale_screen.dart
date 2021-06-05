import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/edit_item_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/views/items_list_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:share/share.dart';

class SaleScreen extends StatefulWidget {
  final String id;
  final Sale sale;

  SaleScreen(this.id, {required this.sale});

  SaleScreen.sale(Sale fullSale)
      : this.id = fullSale.id,
        this.sale = fullSale;

  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
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
                        return EditItemScreen(item: null, sale: widget.sale);
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
