import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/edit_item_screen.dart';
import 'package:flutter_app/shared/views/item_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ItemScreen extends StatefulWidget {
  final String id;
  final String saleId;
  final Item item;
  final Sale sale;

  ItemScreen(this.id, this.saleId, {required this.item, required this.sale});

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  late Item item;
  late Sale sale;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    this.item = widget.item;
    this.sale = widget.sale;
  }
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
              onSelected: (value) async {
                if (value == 'Edit') {
                  var res = await Navigator.of(context).push(platformPageRoute(
                    context: context,
                    builder: (BuildContext context) {
                      return EditItemScreen(item: this.item, sale: this.sale);
                    },
                  ));

                  if (res != null) {
                    setState(() {
                      this.item = res['item'];
                      if (res['new'] == true) {
                        this.sale = Sale.fromJson(sale.id, {...sale.toJson(), 'itemsCount': sale.itemsCount + 1});
                      }
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: ItemView(this.item, this.sale),
      ),
    );
  }
}
