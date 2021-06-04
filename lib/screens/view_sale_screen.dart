import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/create_item_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
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
              )),
        ],
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Stack(children: [
                    Container(
                      color: Color(0xff333333),
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'ALL SALES',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 45,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFFBF4),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
                Container(
                    child: Expanded(child: ItemsListView(sale: widget.sale))),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FilledButton.text(
                  'NEW SALE',
                  width: double.infinity,
                  onPressed: () {
                    print('clicked');
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
