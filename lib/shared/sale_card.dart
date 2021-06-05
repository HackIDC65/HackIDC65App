import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/sale_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SaleCard extends StatefulWidget {
  final Sale sale;

  SaleCard(this.sale);

  @override
  _SaleCardState createState() => _SaleCardState();
}

class _SaleCardState extends State<SaleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        window.history.pushState({}, widget.sale.title, "sale/${widget.sale.id}");
        Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (BuildContext context) {
            return SaleScreen.sale(widget.sale);
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
        padding: EdgeInsets.fromLTRB(3, 15, 3, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.sale.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                widget.sale.itemsCount.toString() + ' items on sale',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ),
    );
  }
}
