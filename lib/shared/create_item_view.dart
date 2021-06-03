import 'dart:io';

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
    address = widget.item?.address;
    count = widget.item?.count;
    pickupTime = widget.item?.pickupTime;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Gallery(
              images: images,
              onAddImageClicked: () {
                getImage(context, (pickedFile) {
                  setState(() {
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
                  hintText: AppLocalizations.of(context)?.itemDescriptionHint,
                ),
                SizedBox(height: 8),
                PlatformTextFormField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(text: address ?? ''),
                  ),
                  onChanged: (value) {
                    setState(() {
                      this.address = value;
                    });
                  },
                  hintText: AppLocalizations.of(context)?.itemAddressHint,
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
                  hintText: AppLocalizations.of(context)?.itemAvailableFromHint,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          FilledButton.text(
            (widget.item != null
                    ? AppLocalizations.of(context)?.saveItem
                    : AppLocalizations.of(context)?.createItem) ??
                "",
            onPressed: () {
              
            },
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
