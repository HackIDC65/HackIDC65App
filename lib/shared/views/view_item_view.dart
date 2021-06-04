import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/custom_chip.dart';
import 'package:flutter_app/shared/filled_button.dart';

class ViewItemView extends StatefulWidget {
  final Item item;
  final Sale sale;

  ViewItemView(this.item, this.sale);

  @override
  _ViewItemViewState createState() => _ViewItemViewState();
}

class _ViewItemViewState extends State<ViewItemView> {
  late Item item;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    this.item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
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
                      child: ((item.images?.length ?? 0) > 0) ? Image.network(
                        item.images?[0] ?? '',
                        fit: BoxFit.cover,
                      ) : Container(),
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
                              if (widget.item.reserved)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: CustomChip(
                                    "Reserved",
                                    color: Colors.red,
                                    textColor: Colors.white,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(children: [
                                Text(
                                  widget.item.title ?? "no title",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(fontSize: 28.0),
                                )
                              ]),
                              SizedBox(height: 8),
                              Wrap(
                                children: [
                                  Text(
                                    widget.item.desc ?? "No description...",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            widget.item.price == 0
                                ? 'Free!'
                                : widget.item.price == null
                                    ? 'Free!'
                                    : '₪${widget.item.price?.toString()}',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      fontSize: 30.0,
                                      color: const Color(0xff19BD2E),
                                    ),
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                      _buildField(
                        context,
                        "Available From",
                        widget.item.pickupTime?.toString() ?? "unknown",
                      ),
                      SizedBox(height: 37),
                      _buildField(
                        context,
                        "Quantity",
                        (widget.item.count ?? 1).toString(),
                      ),
                      SizedBox(height: 37),
                      _buildField(
                        context,
                        "Dimensions",
                        widget.item.desc ?? "unknown",
                      ),
                      SizedBox(height: 37),
                      _buildField(context, "Address", "address"),
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
                      child: Icon(Icons.call),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 3),
                      onPressed: () {
                        print(widget.item.id + ' was Reserved');
                      },
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: FilledButton(
                        child: Text(
                          'Reserve Now!',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        color: widget.item.reserved ? Colors.grey : const Color(0Xffffbf00),
                        onPressed: () {
                          CollectionReference items = FirebaseFirestore.instance
                              .collection('sales')
                              .doc(widget.sale.id)
                              .collection('items');

                          items.doc(widget.item.id).set({'reserved': true},
                              SetOptions(merge: true)).then((res) {
                            setState(() {
                              widget.item.reserved = true;
                            });
                          });
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
        Divider(),
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
