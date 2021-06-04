import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/gallery.dart';
import 'package:flutter_app/utils/get_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CreateItemView extends StatefulWidget {
  final Item? item;
  final Sale sale;

  const CreateItemView({required this.sale, this.item});

  @override
  _CreateItemViewState createState() => _CreateItemViewState();
}

class _CreateItemViewState extends State<CreateItemView> {
  List images = [];
  String? title;
  int? price;
  String? desc;
  String? address;
  int? count;
  DateTime? pickupTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.item == null) return;

    title = widget.item?.title;
    price = widget.item?.price;
    desc = widget.item?.desc;
    count = widget.item?.count;
    pickupTime = widget.item?.pickupTime;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 230,
                child: Stack(children: [
                  Container(
                    color: Color(0xff333333),
                    height: double.infinity,
                    width: double.infinity,
                    child: Gallery(
                      images: images,
                      onAddImageClicked: () {
                        getImage(context, (pickedFile) {
                          setState(() {
                            if (pickedFile != null) {
                              firebase_storage.Reference ref =
                              firebase_storage.FirebaseStorage.instance.ref();
                              ref.putFile(File(pickedFile.path))
                                  .then((a) => ref.getDownloadURL())
                                  .then((url) => print(url));
                            }
                            if (pickedFile != null) {
                              images.add(File(pickedFile.path));
                            } else {
                              print('No image selected.');
                            }
                          });
                        });
                      },
                    ),
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
                        setState(() {
                          this.title = value;
                        });
                      },
                      hintText: AppLocalizations.of(context)?.itemTitleHint,
                    ),
                    SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: price?.toString() ?? ''),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          this.price = int.parse(value);
                        });
                      },
                      hintText: AppLocalizations.of(context)?.itemPriceHint,
                    ),
                    SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: desc ?? ''),
                      ),
                      onChanged: (value) {
                        setState(() {
                          this.desc = value;
                        });
                      },
                      hintText:
                          AppLocalizations.of(context)?.itemDescriptionHint,
                    ),
                    SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: count?.toString() ?? ''),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          this.count = int.parse(value);
                        });
                      },
                      hintText: AppLocalizations.of(context)?.itemCountHint,
                    ),
                    SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: count?.toString() ?? ''),
                      ),
                      onChanged: (value) {
                        setState(() {
                          this.pickupTime = DateTime.parse(value);
                        });
                      },
                      hintText:
                          AppLocalizations.of(context)?.itemAvailableFromHint,
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
              (widget.item != null
                  ? AppLocalizations.of(context)?.saveItem
                  : AppLocalizations.of(context)?.createItem) ??
                  "",
              width: double.infinity,
              onPressed: () async {
                CollectionReference items = FirebaseFirestore.instance
                    .collection('sales')
                    .doc(widget.sale.id)
                    .collection('items');
                var id = widget.item?.id;

                var delta = {
                  'title': this.title,
                  'price': this.price,
                  'desc': this.desc,
                  'address': this.address,
                  'count': this.count,
                  'pickupTime': this.pickupTime,
                };
                if (id != null) {
                  await items.doc(id).set(delta);
                } else {
                  await items.add(delta);
                }

                return Navigator.of(context).pop();
              },
            ),
          ),
        )
      ],
    );
  }
}
