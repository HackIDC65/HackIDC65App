import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/shared/item_card.dart';

class ItemsListView extends StatelessWidget {
  // final List<String> items = <String>['A', 'B', 'C'];
  final items = [
    Item(
        id: '1',
        title: 'Round Dinner Table',
        price: 15,
        desc: 'An amazing dinner table 2 years old'),
    Item(
        id: '2',
        title: 'Round Dinner Table',
        price: 0,
        desc: 'An amazing dinner table 2 years old'),
    Item(
        id: '3',
        title: 'Round Dinner Table',
        price: 15,
        desc: 'An amazing dinner table 2 years old'),
    Item(
        id: '4',
        title: 'Round Dinner Table',
        price: 15,
        desc: 'An amazing dinner table 2 years old'),
    Item(
        id: '5',
        title: 'Round Dinner Table',
        price: 15,
        desc: 'An amazing dinner table 2 years old')
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ItemCard(item: items[index]);
      },
      padding: const EdgeInsets.all(10),
      itemCount: items.length,
    );
  }
}
