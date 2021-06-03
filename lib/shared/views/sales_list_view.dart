import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/sale_card.dart';

class SalesListView extends StatelessWidget {
  final sales = [
    Sale(id: '1', title: 'sale1', itemsCount: 3, location: 'David HaMelech 71'),
    Sale(id: '2', title: 'sale3', itemsCount: 7, location: 'David HaMelech 71'),
    Sale(id: '3', title: 'sale4', itemsCount: 1, location: 'David HaMelech 71'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return SaleCard(sales[index]);
      },
      padding: const EdgeInsets.all(10),
      itemCount: sales.length,
    );
  }
}
