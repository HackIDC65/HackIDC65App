import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/view_item_screen.dart';
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
            return ViewItemScreen(this.item.id, this.sale.id,
                item: this.item, sale: this.sale);
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFFFBF4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
          image: DecorationImage(
              image: NetworkImage(item.images?[0] ?? ''), fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20)),
          ),
          Positioned(
              bottom: 10.0,
              left: 10.0,
              child: Text(
                item.title.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )),
          Positioned(
              top: 30,
              left: 0,
              child: Container(
                color: Color(0xE668DB46),
                padding: EdgeInsets.fromLTRB(25, 3, 8, 3),
                child: Text(
                    item.price == 0
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
