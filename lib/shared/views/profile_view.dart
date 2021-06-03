import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/get_image.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              getImage(context, (image) {
                if (image == null) return;

                setState(() {
                  _image = File(image.path);
                });
              });
            },
            child: Container(
              margin: EdgeInsets.all(20),
              height: 200.0,
              width: 200.0,
              child: ClipRRect(
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.fill)
                    : Image.network('graphics/anonymous_user.png',
                        fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text("Israel Israeli",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  leading: Icon(
                    Icons.person,
                  ),
                ),
                ListTile(
                  title: Text("Tel Aviv, Israel",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  leading: Icon(
                    Icons.place,
                  ),
                ),
                ListTile(
                  title: Text("+972-541234567",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  leading: Icon(
                    Icons.phone,
                  ),
                ),
                ListTile(
                  title: Text("israel@israeli.com",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  leading: Icon(
                    Icons.email,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
