import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/sale_screen.dart';
import 'package:flutter_app/shared/platform/window/noweb_window.dart'
    if (dart.library.html) 'package:flutter_app/shared/platform/window/web_window.dart';
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
        if (hasWindow) {
          window.history
              .pushState({}, widget.sale.title, "sale/${widget.sale.id}");
          Navigator.of(context).pushNamed("/sale/${widget.sale.id}");
        } else {
          Navigator.of(context).push(platformPageRoute(
            context: context,
            builder: (BuildContext context) {
              return SaleScreen.sale(widget.sale);
            },
          ));
        }
      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.sale.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
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
