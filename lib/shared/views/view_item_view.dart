import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/shared/filled_button.dart';

class ViewItemView extends StatefulWidget {
  final Item item;

  ViewItemView(this.item);

  @override
  _ViewItemViewState createState() => _ViewItemViewState();
}

class _ViewItemViewState extends State<ViewItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: IntrinsicWidth(
                child: Image.asset(
                  'images/sofa_demo.jpg',
                  height: 160,
                  width: 1500,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    widget.item.title ?? '',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    widget.item.desc ?? '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: FilledButton(
          child: Text(
            'Reserve This Item!',
            style: Theme.of(context).textTheme.headline5,
          ),
          onPressed: () {
            print(widget.item.id + ' was Reserved');
          },
        ),
      ),
    );
  }
}
