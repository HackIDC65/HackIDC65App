import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/edit_sale_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/login_button.dart';
import 'package:flutter_app/shared/sale_card.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shimmer/shimmer.dart';

class SalesListView extends StatefulWidget {
  const SalesListView();

  @override
  _SalesListViewState createState() => _SalesListViewState();
}

class _SalesListViewState extends State<SalesListView> {
  User? user;
  late Stream<QuerySnapshot?> _salesStream;

  _SalesListViewState() {
    _salesStream =
        FirebaseAuth.instance.authStateChanges().asyncExpand((event) {
      user = event;
      if (event == null) return Stream.value(null);
      return FirebaseFirestore.instance
          .collection('sales')
          .where("userId", isEqualTo: event.uid)
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: _salesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        var salesList = snapshot.data?.docs.map((DocumentSnapshot document) {
              return Sale.fromJson(
                  document.id, document.data()! as Map<String, Object?>);
            }).toList() ??
            [];

        return Stack(
          children: [
            Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0)
                    return SizedBox(
                      height: 80,
                      child: Stack(
                        children: [
                          Container(
                            color: Color(0xff333333),
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'ALL SALES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.4,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFFBF4),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            topRight: Radius.circular(24),
                                          ),
                                        ),
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
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: _buildShimmerItem(context),
                    );

                  if (this.user == null) return _buildNotLoggedIn(context);

                  if (salesList.length == 0)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("You don't have any sales yet"),
                      ],
                    );

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SaleCard(salesList[index - 1]),
                  );
                },
                itemCount: snapshot.connectionState == ConnectionState.waiting
                    ? 6
                    : (salesList.length == 0 ? 2 : salesList.length + 1),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FilledButton.text(
                  'NEW SALE',
                  width: double.infinity,
                  onPressed: () {
                    Navigator.of(context).push(platformPageRoute(
                      context: context,
                      builder: (BuildContext context) {
                        return EditSaleScreen();
                      },
                    ));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotLoggedIn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("You are not logged in, log in to create a new sale"),
          Container(height: 16),
          LoginButton(),
        ],
      ),
    );
  }

  _buildShimmerItem(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Color(0xffFFFBF4),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          )
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffFFFBF4),
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
    );
  }
}
