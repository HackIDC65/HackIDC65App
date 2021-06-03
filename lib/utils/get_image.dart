

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_picker/image_picker.dart';

Future getImage(BuildContext context, Function cb) async {
  showPlatformModalSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Photo'),
            onTap: () async {
              Navigator.pop(context);
              var image = ImagePicker().getImage(source: ImageSource.gallery);
              cb(image);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Camera'),
            onTap: () async {
              Navigator.pop(context);
              var image = ImagePicker().getImage(source: ImageSource.camera);
              cb(image);
            },
          ),
        ],
      );
    },
  );
}