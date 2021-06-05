import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EditSaleView extends StatefulWidget {
  final Sale? sale;

  const EditSaleView({this.sale});

  @override
  _EditSaleViewState createState() => _EditSaleViewState();
}

class ImageHolder {
  final String? url;
  final File? file;

  const ImageHolder({this.file, this.url});
}

class _EditSaleViewState extends State<EditSaleView> {
  String? title;
  String? location;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.sale == null) return;

    title = widget.sale?.title;
    location = widget.sale?.location;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null)
      return Center(
        child: Column(
          children: [
            Text("You are not logged in"),
            FilledButton.text(
              "Go back",
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Stack(children: [
                  Container(
                    color: Color(0xff333333),
                    height: double.infinity,
                    width: double.infinity,
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
                                  color: const Color(0xfffffbf4),
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: title ?? ''),
                      ),
                      onChanged: (value) {
                        this.title = value;
                      },
                      hintText: AppLocalizations.of(context)?.itemTitleHint,
                    ),
                    SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: location ?? ''),
                      ),
                      onChanged: (value) {
                        this.location = value;
                      },
                      hintText: AppLocalizations.of(context)?.itemAddressHint,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
            child: FilledButton.text(
              (widget.sale != null
                      ? AppLocalizations.of(context)?.saveSale
                      : AppLocalizations.of(context)?.createSale) ??
                  "",
              width: double.infinity,
              onPressed: () async {
                CollectionReference items =
                    FirebaseFirestore.instance.collection('sales');

                final id = widget.sale?.id;

                var delta = {
                  'title': this.title,
                  'location': this.location,
                  'userId': user.uid,
                };
                Sale sale;
                if (id != null) {
                  await items.doc(id).set(delta);
                  var cur = widget.sale!.toJson();
                  cur.addAll(delta);
                  sale = Sale.fromJson(id, cur);
                } else {
                  var res = await items.add(delta);
                  sale = Sale.fromJson(res.id, delta);
                }

                return Navigator.of(context).pop(sale);
              },
            ),
          ),
        )
      ],
    );
  }
}
