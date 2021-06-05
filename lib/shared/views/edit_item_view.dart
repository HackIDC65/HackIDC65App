import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/loader.dart';
import 'package:flutter_app/utils/get_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class EditItemView extends StatefulWidget {
  final Item? item;
  final Sale sale;

  const EditItemView({required this.sale, this.item});

  @override
  _EditItemViewState createState() => _EditItemViewState();
}

class ImageHolder {
  final String? url;
  final File? file;

  const ImageHolder({this.file, this.url});
}

class _EditItemViewState extends State<EditItemView> {
  List<ImageHolder> images = [];
  bool loadingImage = false;
  String? title;
  int? price;
  String? desc;
  String? dimensions;
  int? count;
  DateTime? _selectedDay;
  DateTime? _focusedDay;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.item == null) return;

    images = widget.item?.images?.map((e) => ImageHolder(url: e)).toList() ?? [];
    title = widget.item?.title;
    price = widget.item?.price;
    desc = widget.item?.desc;
    dimensions = widget.item?.dimensions;
    count = widget.item?.count;
    _selectedDay = widget.item?.pickupTime;
    _focusedDay = widget.item?.pickupTime;
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
                    child: GestureDetector(
                      onTap: () {
                        getImage(context, (pickedFile) {
                          if (pickedFile != null) {
                            setState(() {
                              loadingImage = true;
                            });
                            firebase_storage.Reference ref = firebase_storage
                                .FirebaseStorage.instance
                                .ref("${DateTime.now()}.png");
                            ref.putFile(File(pickedFile.path)).then((a) {
                              return ref.getDownloadURL();
                            }).then((url) {
                              setState(() {
                                images = [ImageHolder(
                                  file: File(pickedFile.path),
                                  url: url,
                                )];
                                loadingImage = false;
                              });
                            });
                          }
                        });
                      },
                      child: Container(
                        child: loadingImage ? Center(child: Loader()) : (images.length == 0
                                ? Center(
                                    child: Icon(
                                    Icons.photo_camera_outlined,
                                    size: 60,
                                    color: const Color(0xfffffbf4),
                                  ))
                                : loadingImage
                                    ? Center(child: Loader())
                                    : (images[0].file != null
                                        ? Image.file(
                                            images[0].file!,
                                            fit: BoxFit.fitWidth,
                                          )
                                        : Image.network(
                                            images[0].url!,
                                            fit: BoxFit.fitWidth,
                                          ))),
                      ),
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
                        TextEditingValue(text: price?.toString() ?? ''),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        this.price = int.parse(value);
                      },
                      hintText: AppLocalizations.of(context)?.itemPriceHint,
                    ),
                    SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: desc ?? ''),
                      ),
                      onChanged: (value) {
                        this.desc = value;
                      },
                      hintText:
                      AppLocalizations.of(context)?.itemDescriptionHint,
                    ),
                    SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: dimensions ?? ''),
                      ),
                      onChanged: (value) {
                        this.dimensions = value;
                      },
                      hintText:
                      AppLocalizations.of(context)?.itemDimensionsHint,
                    ),
                    SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: count?.toString() ?? ''),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        this.count = int.parse(value);
                      },
                      hintText: AppLocalizations.of(context)?.itemCountHint,
                    ),
                    SizedBox(height: 8),
                    TableCalendar(
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay ?? DateTime.now(),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
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
                DocumentReference saleRef = FirebaseFirestore.instance
                    .collection('sales')
                    .doc(widget.sale.id);
                CollectionReference items = saleRef.collection('items');
                var id = widget.item?.id;

                var delta = {
                  'title': this.title,
                  'images': images.map((e) => e.url).toList().where((element) => element != null).toList(),
                  'price': this.price,
                  'desc': this.desc,
                  'dimensions': this.dimensions,
                  'count': this.count,
                  'pickupTime': this._selectedDay,
                };

                Item newItem;
                if (id != null) {
                  await items.doc(id).set(delta);
                  await saleRef.set({'itemsCount': FieldValue.increment(1)}, SetOptions(merge: true));
                  var res = widget.item!.toJson();
                  res.addAll(delta);
                  newItem = Item.fromJson(id, res);
                } else {
                  final res = await items.add(delta);
                  newItem = Item.fromJson(res.id, delta);
                }

                return Navigator.of(context).pop({'item': newItem, 'new': id == null});
              },
            ),
          ),
        )
      ],
    );
  }
}
