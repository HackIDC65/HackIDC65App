import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/filled_button.dart';

class ViewItemView extends StatefulWidget {
  final String id;

  ViewItemView(this.id);

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
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: FilledButton(
          child: Text('Reserve This Item!'),
          onPressed: () {
            print(widget.id + ' was Reserved');
          },
        ),
      ),
    );
  }
}
