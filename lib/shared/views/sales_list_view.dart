import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/sale_card.dart';

class SalesListView extends StatefulWidget {
  const SalesListView();

  @override
  _SalesListViewState createState() => _SalesListViewState();
}

class _SalesListViewState extends State<SalesListView> {
  final Stream<QuerySnapshot> _salesStream =
      FirebaseFirestore.instance.collection('sales').snapshots();

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
              return Sale.fromJson(
                  document.id, document.data()! as Map<String, Object?>);
            }).toList() ??
            [];

        return Stack(
          children: [
            Container(
              child: Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) return SizedBox(
                    height: 100,
                    child: Stack(children: [
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
                                fontSize: 16,),
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
                      )
                    ]),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SaleCard(salesList[index - 1]),
                  );
                },
                itemCount: salesList.length + 1,
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FilledButton.text(
                  'NEW SALE',
                  width: double.infinity,
                  onPressed: () {
                    print('clicked');
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
