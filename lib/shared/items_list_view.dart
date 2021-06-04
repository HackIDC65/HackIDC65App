import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/create_item_screen.dart';
import 'package:flutter_app/shared/item_card.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:share/share.dart';

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
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                PlatformIconButton(
                  icon: Icon(context.platformIcons.share),
                  onPressed: () {
                    Share.share('Check out my new sale https://sales-now.com/${widget.sale.id}');
                  },
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return {'Edit', 'Delete'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ))
              ],
              leading: Builder(
                builder: (context) => PlatformIconButton(
                  icon: Image.asset("graphics/ic_back.png"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
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
                    Text(widget.sale.title, style:
                    Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                    Flexible(
                      child: Text(
                        widget.sale.location,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.headline6?.copyWith(
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
              //       Share.share('Check out my new sale https://sales-now.com/${widget.sale.id}');
              //     },
              //   ),
              //   PlatformIconButton(
              //     icon: Icon(context.platformIcons.add),
              //     onPressed: () {
              //       Navigator.of(context).push(platformPageRoute(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return CreateItemScreen(item: null, sale: widget.sale);
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
                  if (index >= itemsList.length) Container();
                  return Padding(
                    child: ItemCard(item: itemsList[index], sale: widget.sale),
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
