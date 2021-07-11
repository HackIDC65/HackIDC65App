import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/shared/custom_chip.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';

class ItemView extends StatefulWidget {
  final Item item;
  final Sale sale;

  ItemView(this.item, this.sale);

  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  late Item item;
  late Sale sale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.item = widget.item;
    this.sale = widget.sale;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 230,
                      child: Stack(children: [
                        Container(
                          color: Colors.grey,
                          height: double.infinity,
                          width: double.infinity,
                          child: ((item.images?.length ?? 0) > 0)
                              ? Image.network(
                                  item.images?[0] ?? '',
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 45,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (item.fullyReserved())
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 24),
                                        child: CustomChip(
                                          "Reserved",
                                          color: Colors.red,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? "Missing Title",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(fontSize: 28.0),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      item.desc ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                item.price == 0
                                    ? 'Free!'
                                    : item.price == null
                                        ? 'Free!'
                                        : '₪${item.price?.toString()}',
                                style:
                                    Theme.of(context).textTheme.headline4?.copyWith(
                                          fontSize: 30.0,
                                          color: item.fullyReserved()
                                              ? Colors.grey
                                              : const Color(0xff19BD2E),
                                          decoration: item.fullyReserved()
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                              )
                            ],
                          ),
                          SizedBox(height: 32),
                          _buildField(
                            context,
                            "Available From",
                            item.pickupTime != null
                                ? DateFormat.yMMMMd().format(item.pickupTime!)
                                : "Unknown",
                          ),
                          SizedBox(height: 16),
                          _buildField(
                            context,
                            "Quantity",
                            (item.count ?? 1).toString(),
                          ),
                          SizedBox(height: 16),
                          _buildField(
                            context,
                            "Dimensions",
                            item.dimensions ?? "Unknown",
                          ),
                          SizedBox(height: 16),
                          _buildField(
                            context,
                            "Address",
                            widget.sale.location,
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        FilledButton(
                          height: 42,
                          width: 42,
                          padding: EdgeInsets.zero,
                          child: Icon(Icons.call),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 3),
                          onPressed: () {
                            print(item.id + ' was Reserved');
                          },
                        ),
                        SizedBox(width: 16),
                        if (snapshot.data?.uid != this.sale.userId)
                        Expanded(
                          child: FilledButton(
                            child: Text(
                              item.fullyReserved()
                                  ? 'Reserved 0_0'
                                  : 'Reserve Now!',
                              style:
                                  Theme.of(context).textTheme.headline5?.copyWith(
                                        color: item.fullyReserved()
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                            ),
                            color: item.fullyReserved()
                                ? Colors.grey
                                : const Color(0Xffffbf00),
                            onPressed: () async {
                              User? user = FirebaseAuth.instance.currentUser ??
                                  await Navigator.of(context)
                                      .push(platformPageRoute(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return LoginScreen();
                                    },
                                  ));

                              if (user == null) return;

                              CollectionReference orders = FirebaseFirestore
                                  .instance
                                  .collection('sales')
                                  .doc(widget.sale.id)
                                  .collection('orders');

                              DocumentReference itemRef = FirebaseFirestore.instance
                                  .collection('sales')
                                  .doc(widget.sale.id)
                                  .collection('items')
                                  .doc(this.item.id);

                              var res = await orders.doc().set({
                                'date': DateTime.now(),
                                'items': [
                                  {
                                    'itemId': item.id,
                                    'count': 1,
                                    'status': 'pending',
                                    'user': ''
                                  },
                                ],
                              });

                              var res1 = itemRef.set(
                                {
                                  'reservedCount':
                                      (item.toJson()['reservedCount'] as int? ??
                                              0) +
                                          1
                                },
                                SetOptions(merge: true),
                              );

                              setState(() {
                                var json = item.toJson();
                                var reservedCount =
                                    json['reservedCount'] as int? ?? 0;
                                json['reservedCount'] = reservedCount + 1;
                                this.item = Item.fromJson(item.id, json);
                              });

                              return res1;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildField(context, String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
        ),
        Divider(
          thickness: 2,
        ),
        Text(
          value ?? "",
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        )
      ],
    );
  }
}
