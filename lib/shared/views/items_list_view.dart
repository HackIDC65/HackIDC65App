import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/edit_sale_screen.dart';
import 'package:flutter_app/shared/item_card.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

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
    super.didChangeDependencies();

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
                          'Check out my new sale https://hackidc-65-2021.firebaseapp.com/sale/${widget.sale!.id}');
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
              leading: Navigator.of(context).canPop()
                  ? Builder(
                      builder: (context) => PlatformIconButton(
                        icon: Image.asset("graphics/ic_back.png"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  : null,
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
            ),
            if (snapshot.hasError)
              SliverToBoxAdapter(child: Text('Something went wrong')),
            if (!snapshot.hasError) ...[
              SliverPadding(
                padding: EdgeInsets.all(16).copyWith(bottom: 100),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return snapshot.connectionState ==
                                  ConnectionState.waiting
                          ? _buildShimmerItem(context)
                          : ItemCard(item: itemsList[index], sale: this.sale!);
                    },
                    childCount:
                        snapshot.connectionState == ConnectionState.waiting
                            ? 8
                            : itemsList.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  _buildShimmerItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFFFBF4),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffFFFBF4),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
