import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_picker/image_picker.dart';

Future getImage(BuildContext context, Function cb) async {
  if (kIsWeb) {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    cb(image);
    return;
  }
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
              var image =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              cb(image);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Camera'),
            onTap: () async {
              Navigator.pop(context);
              var image =
                  await ImagePicker().getImage(source: ImageSource.camera);
              cb(image);
            },
          ),
        ],
      );
    },
  );
}
