import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/item_card.dart';

class ItemsListView extends StatefulWidget {
  final Sale sale;

  const ItemsListView({required this.sale});

  @override
  _ItemsListViewState createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _itemsStream = FirebaseFirestore.instance
        .collection('sales')
        .doc(widget.sale.id)
        .collection('items')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _itemsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        var itemsList = snapshot.data?.docs.map((DocumentSnapshot document) {
              return Item.fromJson(
                  document.id, document.data()! as Map<String, Object?>);
            }).toList() ??
            [];
        return GridView.builder(
          itemBuilder: (_, index) {
            return ItemCard(item: itemsList[index], sale: widget.sale);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14),
          padding: EdgeInsets.all(30.0),
          itemCount: itemsList.length,
        );
      },
    );
  }
}
