import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/edit_sale_screen.dart';
import 'package:flutter_app/shared/item_card.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:share/share.dart';

import '../loader.dart';

class ItemsListView extends StatefulWidget {
  final String saleId;
  final Sale? sale;

  const ItemsListView(this.saleId, {this.sale});

  @override
  _ItemsListViewState createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  late String saleId;
  late Sale? sale;
  bool first = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // if (first || this.saleId != widget.saleId && widget.saleId.isNotEmpty) {
    //   var uri = Uri.parse(window.location.href);
    //   window.location.href = "${uri.origin}/sale/${widget.saleId}";
    //   first = false;
    // }

    this.saleId = widget.saleId;
    this.sale = widget.sale;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot?> _itemsStream = this.sale == null
        ? Stream.value(null)
        : FirebaseFirestore.instance
            .collection('sales')
            .doc(sale!.id)
            .collection('items')
            .snapshots();

    return StreamBuilder<QuerySnapshot?>(
      stream: _itemsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        var itemsList = snapshot.data?.docs.map((DocumentSnapshot document) {
              return Item.fromJson(
                  document.id, document.data()! as Map<String, Object?>);
            }).toList() ??
            [];
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                if (widget.sale?.id != null)
                  PlatformIconButton(
                    icon: Icon(context.platformIcons.share),
                    onPressed: () {
                      Share.share(
                          'Check out my new sale http://locallhost:5000/sale/${widget.sale!.id}');
                    },
                  ),
                if (widget.sale?.id != null && user?.uid == widget.sale!.id)
                  Container(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton<String>(
                      itemBuilder: (BuildContext context) {
                        return {'Edit', 'Delete'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                      onSelected: (value) async {
                        if (value == 'Edit') {
                          Sale? sale = await Navigator.of(context)
                              .push(platformPageRoute(
                            context: context,
                            builder: (BuildContext context) {
                              return EditSaleScreen(sale: this.sale);
                            },
                          ));

                          if (sale != null) {
                            setState(() {
                              this.sale = sale;
                            });
                          }
                        }
                      },
                    ),
                  ),
              ],
              leading: Navigator.of(context).canPop() ? Builder(
                builder: (context) => PlatformIconButton(
                  icon: Image.asset("graphics/ic_back.png"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ) : null,
              expandedHeight: 180,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 42,
                        color: Colors.white,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xff333333),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(left: 50, right: 24, bottom: 10),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.sale != null ? this.sale!.title : "No Such Sale",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                    Flexible(
                      child: Text(
                        this.sale?.location ?? "none",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              // trailingActions: [
              //   PlatformIconButton(
              //     icon: Icon(context.platformIcons.share),
              //     onPressed: () {
              //       Share.share('Check out my new sale https://sales-now.com/${this.sale.id}');
              //     },
              //   ),
              //   PlatformIconButton(
              //     icon: Icon(context.platformIcons.add),
              //     onPressed: () {
              //       Navigator.of(context).push(platformPageRoute(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return CreateItemScreen(item: null, sale: this.sale);
              //         },
              //       ));
              //     },
              //   ),
              //   Container(
              //       alignment: Alignment.centerRight,
              //       child: PopupMenuButton(
              //         itemBuilder: (BuildContext context) {
              //           return {'Edit', 'Delete'}.map((String choice) {
              //             return PopupMenuItem<String>(
              //               value: choice,
              //               child: Text(choice),
              //             );
              //           }).toList();
              //         },
              //       )),
              // ],
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (this.sale == null) {
                    return Center(child: Text("No such sale"));
                  }

                  return Padding(
                    child: ItemCard(item: itemsList[index], sale: this.sale!),
                    padding: EdgeInsets.only(
                      top: 16,
                      left: index % 2 == 0 ? 16 : 0,
                      right: index % 2 == 1 ? 16 : 0,
                    ),
                  );
                },
                childCount: itemsList.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 0,
              ),
            ),
            SliverFillRemaining(),
          ],
        );
      },
    );
  }
}
