import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewItemView extends StatefulWidget {
  final String id;

  ViewItemView(this.id);

  @override
  _ViewItemViewState createState() => _ViewItemViewState();
}

class _ViewItemViewState extends State<ViewItemView> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(body: ,)
    Container(
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
    );
  }
}
