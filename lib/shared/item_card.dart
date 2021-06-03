import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/screens/view_item_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (BuildContext context) {
            return ViewItemScreen(this.item.id, item: this.item);
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.fromLTRB(3, 3, 3, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Stack(children: [
              IntrinsicWidth(
                child: Image.asset(
                  'images/sofa_demo.jpg',
                  height: 160,
                  width: 1500,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    color: Colors.lightGreenAccent.withOpacity(0.85),
                    padding: EdgeInsets.fromLTRB(8, 3, 35, 3),
                    child: Text(
                        item.price == 0
                            ? 'Free!'
                            : item.price == null
                            ? 'Free!'
                            : '₪${item.price?.toString()}',
                        style: Theme.of(context).textTheme.headline5),
                  )),
            ])),
            Container(
              margin: EdgeInsets.fromLTRB(12, 10, 12, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(item.title ?? '',
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      Container(
                        child: Text(
                          item.desc ?? '',
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                        ),
                        width: 400,
                      ),
                    ],
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
