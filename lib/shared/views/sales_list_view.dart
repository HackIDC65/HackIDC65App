import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/sale_card.dart';

class SalesListView extends StatefulWidget {
  const SalesListView();

  @override
  _SalesListViewState createState() => _SalesListViewState();
}

class _SalesListViewState extends State<SalesListView> {
  final Stream<QuerySnapshot> _salesStream = FirebaseFirestore.instance.collection('sales').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _salesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        var salesList = snapshot.data?.docs.map((DocumentSnapshot document) {
          return Sale.fromJson(document.id, document.data()! as Map<String, Object?>);
        }).toList() ?? [];

        return ListView.builder(
          itemBuilder: (context, index) {
            return SaleCard(salesList[index]);
          },
          padding: const EdgeInsets.all(10),
          itemCount: salesList.length,
        );
      },
    );
  }
}

