import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/item_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Sale sale;

  ItemCard({required this.item, required this.sale});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (BuildContext context) {
            return ItemScreen(this.item.id, this.sale.id,
                item: this.item, sale: this.sale);
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFFFBF4),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          image: DecorationImage(
              image: NetworkImage(item.images?[0] ?? ''), fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0x99333333),
                borderRadius: BorderRadius.circular(10)),
          ),
          Positioned(
            top: 18.0,
            left: 14.0,
            width: 130,
            child: Text(
              item.title.toString().toUpperCase(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.6,
              ),
            ),
          ),
          Positioned(
              bottom: 16,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(3),
                      topLeft: Radius.circular(3)),
                  color: Color(!item.reserved ? 0xD968DB46 : 0xD9ff5757),
                ),
                padding: EdgeInsets.fromLTRB(8, 2, 15, 2),
                child: Text(
                    item.reserved
                        ? 'RESERVED'
                        : item.price == 0
                            ? 'Free!'
                            : item.price == null
                                ? 'Free!'
                                : '₪${item.price?.toString()}',
                    style: Theme.of(context).textTheme.headline5),
              )),
        ]),
      ),
    );
  }
}
