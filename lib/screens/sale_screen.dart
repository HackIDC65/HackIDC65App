import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/edit_item_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/loader.dart';
import 'package:flutter_app/shared/views/items_list_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SaleScreen extends StatefulWidget {
  final String id;
  final Sale? sale;

  SaleScreen.id(this.id) : this.sale = null;

  SaleScreen.sale(Sale sale)
      : this.id = sale.id,
        this.sale = sale;

  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late Stream<Sale?> saleStream;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    this.saleStream = widget.sale != null
        ? Stream.value(widget.sale!)
        : widget.id.isEmpty ? Stream.value(null) : FirebaseFirestore.instance
            .collection('sales')
            .doc(widget.id)
            .snapshots()
            .map((event) =>
                event.exists ? Sale.fromJson(event.id, event.data()!) : null);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: StreamBuilder<Sale?>(
            stream: saleStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("something went wrong"));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loader();
              }

              Sale? sale = snapshot.data;

              return Stack(
                children: [
                  ItemsListView(widget.id, sale: sale),
                  if (user != null && sale?.userId == user?.uid)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: FilledButton.text(
                          'ADD ITEM',
                          width: double.infinity,
                          onPressed: () {
                            Navigator.of(context).push(platformPageRoute(
                              context: context,
                              builder: (BuildContext context) {
                                return EditItemScreen(
                                  item: null,
                                  sale: sale!,
                                );
                              },
                            ));
                          },
                        ),
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}
