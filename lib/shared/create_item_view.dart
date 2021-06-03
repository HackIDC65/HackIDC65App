import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/shared/gallery.dart';
import 'package:flutter_app/utils/get_image.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_picker/image_picker.dart';

class CreateItemView extends StatefulWidget {
  const CreateItemView();

  @override
  _CreateItemViewState createState() => _CreateItemViewState();
}

class _CreateItemViewState extends State<CreateItemView> {
  var images = [];

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
        ],
      ),
    );
  }
}
